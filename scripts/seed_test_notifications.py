"""
Seed test data to verify the notifications backend and frontend without real
matches scheduled for tomorrow.

Usage (from project root, with .env configured):

  # Quick: 3 sample notifications for UI/API (fastest)
  python scripts/seed_test_notifications.py --quick --username YOUR_USER

  # Full: simulates upcoming, live score, and final result via detection logic
  python scripts/seed_test_notifications.py --username YOUR_USER

  # List users in the database
  python scripts/seed_test_notifications.py --list-users
"""

from __future__ import annotations

import argparse
import os
import sys
from pathlib import Path

import psycopg2
from dotenv import load_dotenv

PROJECT_ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(PROJECT_ROOT))

from notification_service import (  # noqa: E402
    NOTIFICATION_TYPE_FINAL_RESULT,
    NOTIFICATION_TYPE_SCORE_CHANGE,
    NOTIFICATION_TYPE_UPCOMING,
    create_notification,
    detect_upcoming_matches,
    process_match_notification_events,
)

TEST_MATCH_ID = 999_999_001


def get_connection():
    load_dotenv(PROJECT_ROOT / ".env")
    url = os.getenv("DATABASE_URL")
    if not url:
        raise SystemExit("DATABASE_URL is not set in .env")
    return psycopg2.connect(url)


def ensure_notifications_unique_constraint(cur) -> None:
    """Apply Module 6.5 constraint if the DB was created before migration 003."""
    cur.execute(
        """
        DO $$
        BEGIN
            IF NOT EXISTS (
                SELECT 1 FROM pg_constraint
                WHERE conname = 'notifications_user_type_match_key'
            ) THEN
                ALTER TABLE notifications
                ADD CONSTRAINT notifications_user_type_match_key
                UNIQUE (user_id, type, related_match_id);
            END IF;
        END $$
        """
    )


def list_users(cur) -> None:
    cur.execute(
        """
        SELECT user_id, username, email, is_admin
        FROM users
        ORDER BY user_id
        """
    )
    rows = cur.fetchall()
    if not rows:
        print("No users found. Register one in the app first.")
        return
    print("\nUsers in database:")
    print("-" * 60)
    for user_id, username, email, is_admin in rows:
        role = "admin" if is_admin else "user"
        print(f"  id={user_id}  username={username!r}  email={email}  ({role})")
    print()


def resolve_user(cur, username: str | None) -> tuple[int, str]:
    if username:
        cur.execute(
            "SELECT user_id, username FROM users WHERE username = %s",
            (username,),
        )
        row = cur.fetchone()
        if not row:
            raise SystemExit(f"User {username!r} not found. Use --list-users.")
        return row[0], row[1]

    cur.execute(
        """
        SELECT user_id, username
        FROM users
        WHERE is_admin = FALSE
        ORDER BY user_id
        LIMIT 1
        """
    )
    row = cur.fetchone()
    if not row:
        cur.execute("SELECT user_id, username FROM users ORDER BY user_id LIMIT 1")
        row = cur.fetchone()
    if not row:
        raise SystemExit("No users in database. Register one in the app first.")
    return row[0], row[1]


def pick_sample_teams(cur) -> tuple[int, int, int, str, str]:
    cur.execute(
        """
        SELECT t1.team_id, t2.team_id, t1.league_id, t1.name, t2.name
        FROM teams t1
        JOIN teams t2 ON t1.league_id = t2.league_id AND t1.team_id < t2.team_id
        WHERE t1.is_active = TRUE AND t2.is_active = TRUE
        ORDER BY t1.league_id, t1.team_id
        LIMIT 1
        """
    )
    row = cur.fetchone()
    if not row:
        raise SystemExit("No active teams found in the database.")
    return row


def ensure_favorite(cur, user_id: int, team_id: int) -> None:
    cur.execute(
        """
        INSERT INTO user_favorites (user_id, entity_type, entity_id)
        VALUES (%s, 'team', %s)
        ON CONFLICT (user_id, entity_type, entity_id) DO NOTHING
        """,
        (user_id, team_id),
    )


def pick_existing_match(cur) -> tuple[int, str, str] | None:
    cur.execute(
        """
        SELECT m.match_id, ht.name, at.name
        FROM matches m
        JOIN teams ht ON m.home_team_id = ht.team_id
        JOIN teams at ON m.away_team_id = at.team_id
        ORDER BY m.match_id DESC
        LIMIT 1
        """
    )
    return cur.fetchone()


def seed_quick(cur, user_id: int, username: str) -> int:
    """Insert three notification types directly (best for frontend-only check)."""
    match = pick_existing_match(cur)
    if not match:
        raise SystemExit("No matches in DB. Run --full instead or sync data first.")

    match_id, home_name, away_name = match
    samples = [
        (
            NOTIFICATION_TYPE_UPCOMING,
            f"[TEST] Upcoming match: {home_name} vs {away_name} on tomorrow",
        ),
        (
            NOTIFICATION_TYPE_SCORE_CHANGE,
            f"[TEST] Score update: {home_name} 2-1 {away_name} (live)",
        ),
        (
            NOTIFICATION_TYPE_FINAL_RESULT,
            f"[TEST] Final result: {home_name} 2-1 {away_name}",
        ),
    ]

    created = 0
    for notif_type, message in samples:
        cur.execute(
            """
            DELETE FROM notifications
            WHERE user_id = %s AND type = %s AND related_match_id = %s
              AND message LIKE '[TEST]%%'
            """,
            (user_id, notif_type, match_id),
        )
        cur.execute(
            """
            INSERT INTO notifications (user_id, type, message, related_match_id, is_read)
            VALUES (%s, %s, %s, %s, %s)
            RETURNING id
            """,
            (user_id, notif_type, message, match_id, notif_type != NOTIFICATION_TYPE_FINAL_RESULT),
        )
        if cur.fetchone():
            created += 1

    print(f"\nQuick seed for user {username!r} (id={user_id}):")
    print(f"  Match used: {match_id} ({home_name} vs {away_name})")
    print(f"  Notifications created: {created}")
    return created


def cleanup_test_match(cur) -> None:
    cur.execute("DELETE FROM scores WHERE match_id = %s", (TEST_MATCH_ID,))
    cur.execute(
        """
        DELETE FROM notifications
        WHERE related_match_id = %s AND message NOT LIKE '[TEST]%%'
        """,
        (TEST_MATCH_ID,),
    )
    cur.execute("DELETE FROM matches WHERE match_id = %s", (TEST_MATCH_ID,))


def seed_full_pipeline(cur, user_id: int, username: str) -> None:
    """Simulate detection: upcoming -> live score -> final result."""
    home_id, away_id, league_id, home_name, away_name = pick_sample_teams(cur)
    ensure_favorite(cur, user_id, home_id)
    cleanup_test_match(cur)

    cur.execute(
        """
        INSERT INTO matches (
            match_id, season_id, league_id, matchday,
            home_team_id, away_team_id, winner, utc_date, status
        )
        VALUES (%s, NULL, %s, 99, %s, %s, NULL, CURRENT_DATE + 1, 'SCHEDULED')
        """,
        (TEST_MATCH_ID, league_id, home_id, away_id),
    )

    upcoming = detect_upcoming_matches(cur)
    print(f"\nFull pipeline for user {username!r} (id={user_id}):")
    print(f"  Test match: {TEST_MATCH_ID} — {home_name} vs {away_name} (tomorrow, SCHEDULED)")
    print(f"  Favorite added: team {home_name} (id={home_id})")
    print(f"  detect_upcoming_matches → {upcoming}")

    cur.execute(
        "UPDATE matches SET status = 'IN_PLAY' WHERE match_id = %s",
        (TEST_MATCH_ID,),
    )
    cur.execute(
        """
        INSERT INTO scores (match_id, full_time_home, full_time_away, half_time_home, half_time_away)
        VALUES (%s, 1, 0, 1, 0)
        """,
        (TEST_MATCH_ID,),
    )
    live = process_match_notification_events(
        cur, TEST_MATCH_ID, home_id, away_id, league_id,
        "SCHEDULED", "IN_PLAY", None, None, 1, 0,
    )
    print(f"  Live score 1-0 → {live}")

    cur.execute(
        "UPDATE scores SET full_time_home = 2, full_time_away = 1 WHERE match_id = %s",
        (TEST_MATCH_ID,),
    )
    score2 = process_match_notification_events(
        cur, TEST_MATCH_ID, home_id, away_id, league_id,
        "IN_PLAY", "IN_PLAY", 1, 0, 2, 1,
    )
    print(f"  Score change 2-1 → {score2}")

    cur.execute(
        "UPDATE matches SET status = 'FINISHED', winner = 'HOME_TEAM' WHERE match_id = %s",
        (TEST_MATCH_ID,),
    )
    final = process_match_notification_events(
        cur, TEST_MATCH_ID, home_id, away_id, league_id,
        "IN_PLAY", "FINISHED", 2, 1, 2, 1,
    )
    print(f"  Final result → {final}")


def main() -> int:
    parser = argparse.ArgumentParser(description="Seed test notifications")
    parser.add_argument("--username", help="Target user (default: first non-admin user)")
    parser.add_argument("--quick", action="store_true", help="Insert 3 demo notifications directly")
    parser.add_argument("--list-users", action="store_true", help="List users and exit")
    args = parser.parse_args()

    conn = get_connection()
    try:
        with conn.cursor() as cur:
            if args.list_users:
                list_users(cur)
                return 0

            user_id, username = resolve_user(cur, args.username)
            ensure_notifications_unique_constraint(cur)

            if args.quick:
                seed_quick(cur, user_id, username)
            else:
                seed_full_pipeline(cur, user_id, username)

        conn.commit()
    except Exception as exc:
        conn.rollback()
        raise SystemExit(f"Error: {exc}") from exc
    finally:
        conn.close()

    print("\nNext steps:")
    print("  1. Log in as that user in the browser")
    print("  2. Open the bell icon in the header or go to /notifications")
    print("  3. Click a notification → should mark read and open /match/<id>")
    print("  4. Check /notifications/history for the full list")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
