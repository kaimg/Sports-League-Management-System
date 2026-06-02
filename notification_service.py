"""Notification detection and persistence for followed teams and leagues."""

from __future__ import annotations

from typing import Any

NOTIFICATION_TYPE_UPCOMING = "upcoming_match"
NOTIFICATION_TYPE_SCORE_CHANGE = "score_change"
NOTIFICATION_TYPE_FINAL_RESULT = "final_result"

LIVE_STATUSES = ("IN_PLAY", "PAUSED", "LIVE")


def _format_score(home: int | None, away: int | None) -> str:
    home_val = home if home is not None else "-"
    away_val = away if away is not None else "-"
    return f"{home_val}-{away_val}"


def _get_team_names(cur, home_team_id: int, away_team_id: int) -> tuple[str, str]:
    cur.execute(
        """
        SELECT
            (SELECT name FROM teams WHERE team_id = %s),
            (SELECT name FROM teams WHERE team_id = %s)
        """,
        (home_team_id, away_team_id),
    )
    row = cur.fetchone()
    if not row:
        return ("Home", "Away")
    return row[0] or "Home", row[1] or "Away"


def get_match_followers(
    cur,
    home_team_id: int,
    away_team_id: int,
    league_id: int | None,
) -> list[int]:
    cur.execute(
        """
        SELECT DISTINCT uf.user_id
        FROM user_favorites uf
        WHERE (uf.entity_type = 'team' AND uf.entity_id IN (%s, %s))
           OR (uf.entity_type = 'league' AND uf.entity_id = %s)
        """,
        (home_team_id, away_team_id, league_id),
    )
    return [row[0] for row in cur.fetchall()]


def create_notification(
    cur,
    user_id: int,
    notification_type: str,
    message: str,
    match_id: int,
    *,
    update_on_conflict: bool = False,
) -> bool:
    """Insert a notification. Returns True if a row was inserted or updated."""
    if update_on_conflict:
        cur.execute(
            """
            INSERT INTO notifications (user_id, type, message, related_match_id)
            VALUES (%s, %s, %s, %s)
            ON CONFLICT (user_id, type, related_match_id)
            DO UPDATE SET
                message = EXCLUDED.message,
                is_read = FALSE,
                created_at = CURRENT_TIMESTAMP
            RETURNING id
            """,
            (user_id, notification_type, message, match_id),
        )
    else:
        cur.execute(
            """
            INSERT INTO notifications (user_id, type, message, related_match_id)
            VALUES (%s, %s, %s, %s)
            ON CONFLICT (user_id, type, related_match_id) DO NOTHING
            RETURNING id
            """,
            (user_id, notification_type, message, match_id),
        )

    return cur.fetchone() is not None


def process_match_notification_events(
    cur,
    match_id: int,
    home_team_id: int,
    away_team_id: int,
    league_id: int | None,
    old_status: str | None,
    new_status: str,
    old_home: int | None,
    old_away: int | None,
    new_home: int | None,
    new_away: int | None,
) -> dict[str, int]:
    """Detect score changes and final results for followers of this match."""
    counts = {"score_change": 0, "final_result": 0}

    followers = get_match_followers(cur, home_team_id, away_team_id, league_id)
    if not followers:
        return counts

    home_name, away_name = _get_team_names(cur, home_team_id, away_team_id)

    score_changed = (new_home, new_away) != (old_home, old_away)
    has_score = new_home is not None and new_away is not None

    if (
        new_status in LIVE_STATUSES
        and score_changed
        and has_score
        and (old_home is not None or old_away is not None or (new_home, new_away) != (0, 0))
    ):
        message = (
            f"Score update: {home_name} {_format_score(new_home, new_away)} {away_name} (live)"
        )
        for user_id in followers:
            if create_notification(
                cur,
                user_id,
                NOTIFICATION_TYPE_SCORE_CHANGE,
                message,
                match_id,
                update_on_conflict=True,
            ):
                counts["score_change"] += 1

    if new_status == "FINISHED" and old_status != "FINISHED" and has_score:
        message = (
            f"Final result: {home_name} {_format_score(new_home, new_away)} {away_name}"
        )
        for user_id in followers:
            if create_notification(
                cur,
                user_id,
                NOTIFICATION_TYPE_FINAL_RESULT,
                message,
                match_id,
            ):
                counts["final_result"] += 1

    return counts


def detect_upcoming_matches(cur, hours_ahead: int = 24) -> dict[str, int]:
    """
    Notify followers about matches starting within the next N hours.
    Uses utc_date (date) plus status; suitable for the current schema.
    """
    counts = {"upcoming_match": 0}
    day_window = max(1, hours_ahead // 24) if hours_ahead >= 24 else 1

    cur.execute(
        """
        SELECT
            m.match_id,
            m.home_team_id,
            m.away_team_id,
            m.league_id,
            m.utc_date,
            ht.name AS home_name,
            at.name AS away_name
        FROM matches m
        JOIN teams ht ON m.home_team_id = ht.team_id
        JOIN teams at ON m.away_team_id = at.team_id
        WHERE m.status IN ('SCHEDULED', 'TIMED', 'POSTPONED')
          AND m.utc_date >= CURRENT_DATE
          AND m.utc_date <= CURRENT_DATE + %s * INTERVAL '1 day'
        """,
        (day_window,),
    )

    for row in cur.fetchall():
        match_id, home_team_id, away_team_id, league_id, utc_date, home_name, away_name = row
        followers = get_match_followers(cur, home_team_id, away_team_id, league_id)
        if not followers:
            continue

        date_label = utc_date.strftime("%b %d, %Y") if utc_date else "soon"
        message = f"Upcoming match: {home_name} vs {away_name} on {date_label}"

        for user_id in followers:
            if create_notification(
                cur,
                user_id,
                NOTIFICATION_TYPE_UPCOMING,
                message,
                match_id,
            ):
                counts["upcoming_match"] += 1

    return counts


def run_notification_detection(db) -> dict[str, Any]:
    """Run all passive detection jobs (upcoming matches)."""
    cur = db.cursor()
    try:
        counts = detect_upcoming_matches(cur)
        db.commit()
        return counts
    except Exception:
        db.rollback()
        raise
    finally:
        cur.close()


def notification_row_to_dict(row: tuple) -> dict[str, Any]:
    return {
        "id": row[0],
        "type": row[1],
        "message": row[2],
        "related_match_id": row[3],
        "is_read": row[4],
        "created_at": row[5].isoformat() if row[5] else None,
    }
