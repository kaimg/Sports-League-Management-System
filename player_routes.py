from flask import Blueprint, render_template, request, redirect, session, url_for, flash
from auth_utils import login_required
from db import get_db_connection
from datetime import datetime, timedelta

player_bp = Blueprint('player', __name__)

@player_bp.route('/dashboard')
@login_required
def dashboard():
    conn = get_db_connection()
    cur = conn.cursor()

    role = session.get('role')
    player_id = session.get('player_id')

    if role == 'admin':
        cur.execute("""
            SELECT m.id, p1.name, p2.name, m.week_commencing, m.scheduled_at,
                   m.score_player1, m.score_player2
            FROM matches m
            JOIN players p1 ON m.player1_id = p1.id
            JOIN players p2 ON m.player2_id = p2.id
            WHERE m.is_completed = FALSE
              AND m.week_commencing + INTERVAL '6 days' < CURRENT_DATE
        """)
    else:
        cur.execute("""
            SELECT m.id, p1.name, p2.name, m.week_commencing, m.scheduled_at,
                   m.score_player1, m.score_player2
            FROM matches m
            JOIN players p1 ON m.player1_id = p1.id
            JOIN players p2 ON m.player2_id = p2.id
            WHERE m.is_completed = FALSE
              AND m.week_commencing + INTERVAL '6 days' < CURRENT_DATE
              AND (m.player1_id = %s OR m.player2_id = %s)
        """, (player_id, player_id))

    overdue_matches = cur.fetchall()
    cur.close()
    conn.close()

    return render_template("dashboard.html", overdue_matches=overdue_matches)



@player_bp.route('/matches')
@login_required
def matches():
    conn = get_db_connection()
    cur = conn.cursor()

    status = request.args.get('status')
    player = request.args.get('player')
    week = request.args.get('week')

    query = """
        SELECT m.id, p1.name, p2.name, m.week_commencing, m.scheduled_at,
               m.score_player1, m.score_player2, m.player1_id, m.player2_id
        FROM matches m
        JOIN players p1 ON m.player1_id = p1.id
        JOIN players p2 ON m.player2_id = p2.id
        WHERE 1=1
    """
    filters = []

    if status == 'upcoming':
        query += " AND m.is_completed = FALSE"
    elif status == 'overdue':
        query += " AND m.is_completed = FALSE AND m.week_commencing < CURRENT_DATE"
    elif status == 'completed':
        query += " AND m.is_completed = TRUE"

    if player:
        query += " AND (p1.name ILIKE %s OR p2.name ILIKE %s)"
        filters.extend([f"%{player}%", f"%{player}%"])

    if week:
        query += " AND m.week_commencing = %s"
        filters.append(week)

    query += " ORDER BY m.week_commencing DESC, m.scheduled_at ASC"

    cur.execute(query, filters)
    matches = cur.fetchall()

    cur.execute("SELECT DISTINCT week_commencing FROM matches ORDER BY week_commencing DESC")
    weeks = [row[0].strftime('%Y-%m-%d') for row in cur.fetchall()]

    cur.execute("SELECT id, name FROM players ORDER BY name")
    all_players = cur.fetchall()

    cur.close()
    conn.close()

    return render_template(
        'matches.html',
        matches=matches,
        all_players=all_players,
        weeks=weeks,
        datetime=datetime,
        timedelta=timedelta
    )


@player_bp.route('/matches/<int:match_id>/schedule', methods=['POST'])
@login_required
def schedule_match_inline(match_id):
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("SELECT player1_id, player2_id FROM matches WHERE id = %s", (match_id,))
    match = cur.fetchone()

    if not match:
        flash("Match not found.", "danger")
        return redirect(url_for('player.matches'))

    cur.execute("SELECT id FROM players WHERE user_id = %s", (session['user_id'],))
    player = cur.fetchone()

    is_admin = session.get('role') == 'admin'
    if not is_admin and (not player or player[0] not in match):
        flash("You are not authorized to schedule this match.", "danger")
        return redirect(url_for('player.matches'))

    scheduled_at = request.form['scheduled_at']
    try:
        datetime.strptime(scheduled_at, "%Y-%m-%dT%H:%M")
        cur.execute("UPDATE matches SET scheduled_at = %s WHERE id = %s", (scheduled_at, match_id))
        conn.commit()
        flash("Match successfully scheduled!", "success")
    except ValueError:
        flash("Invalid date format.", "danger")
    finally:
        cur.close()
        conn.close()

    return redirect(url_for('player.matches'))


@player_bp.route('/matches/<int:match_id>/score', methods=['GET', 'POST'])
@login_required
def enter_score(match_id):
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("""
        SELECT m.id, p1.name, p2.name, m.scheduled_at, m.score_player1, m.score_player2,
               m.player1_id, m.player2_id
        FROM matches m
        JOIN players p1 ON m.player1_id = p1.id
        JOIN players p2 ON m.player2_id = p2.id
        WHERE m.id = %s
    """, (match_id,))
    match = cur.fetchone()

    if not match:
        flash("Match not found.", "danger")
        return redirect(url_for('player.matches'))

    user_id = session.get('user_id')
    role = session.get('role')

    # ✅ Correct check: compare player.id with player1_id and player2_id
    cur.execute("SELECT id FROM players WHERE user_id = %s", (user_id,))
    player = cur.fetchone()
    is_admin = role == 'admin'

    if not is_admin and (not player or player[0] not in (match[6], match[7])):
        flash("You can only score matches you're involved in.", "danger")
        return redirect(url_for('player.matches'))

    if request.method == 'POST':
        try:
            score1 = int(request.form['score1'])
            score2 = int(request.form['score2'])

            if not (-4 <= score1 <= 8) or not (-4 <= score2 <= 8):
                flash("Scores must be between -4 and 8.", "danger")
                return redirect(url_for('player.enter_score', match_id=match_id))

            if not ((score1 == 8 and score2 < 8) or (score2 == 8 and score1 < 8) or (score1 == 7 and score2 == 7)):
                flash("Invalid result: One player must reach 8, or it must be 7–7 for a draw.", "danger")
                return redirect(url_for('player.enter_score', match_id=match_id))

            cur.execute("""
                UPDATE matches 
                SET score_player1 = %s, score_player2 = %s, is_completed = TRUE 
                WHERE id = %s
            """, (score1, score2, match_id))
            conn.commit()
            flash("Score submitted!", "success")
        except ValueError:
            flash("Scores must be integers.", "danger")
        finally:
            cur.close()
            conn.close()
        return redirect(url_for('player.matches'))

    cur.close()
    conn.close()
    return render_template('enter_score.html', match=match)



@player_bp.route('/leaderboard')
@login_required
def leaderboard():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("""
        SELECT 
            p.name,
            COUNT(m.id) AS games_played,
            SUM(
                CASE 
                    WHEN (p.id = m.player1_id AND m.score_player1 > m.score_player2) OR 
                         (p.id = m.player2_id AND m.score_player2 > m.score_player1)
                    THEN 3
                    WHEN m.score_player1 = m.score_player2 THEN 1
                    ELSE 0
                END
            ) AS points,
            SUM(
                CASE 
                    WHEN (p.id = m.player1_id AND m.score_player1 > m.score_player2) OR 
                         (p.id = m.player2_id AND m.score_player2 > m.score_player1)
                    THEN 1 ELSE 0
                END
            ) AS wins,
            SUM(CASE WHEN m.score_player1 = m.score_player2 THEN 1 ELSE 0 END) AS draws,
            SUM(
                CASE 
                    WHEN (p.id = m.player1_id AND m.score_player1 < m.score_player2) OR 
                         (p.id = m.player2_id AND m.score_player2 < m.score_player1)
                    THEN 1 ELSE 0
                END
            ) AS losses
        FROM players p
        LEFT JOIN matches m ON p.id IN (m.player1_id, m.player2_id)
        WHERE m.is_completed = TRUE
        GROUP BY p.id
        ORDER BY points DESC
    """)
    leaderboard = cur.fetchall()
    cur.close()
    conn.close()
    return render_template('leaderboard.html', leaderboard=leaderboard)


@player_bp.route('/profile/create', methods=['GET', 'POST'])
@login_required
def create_profile():
    user_id = session.get('user_id')
    conn = get_db_connection()
    cur = conn.cursor()
    if request.method == 'POST':
        name = request.form['name']
        cur.execute("INSERT INTO players (name, user_id) VALUES (%s, %s)", (name, user_id))
        conn.commit()
        flash("Profile created!", "success")
        return redirect(url_for('player.dashboard'))
    cur.close()
    conn.close()
    return render_template('create_profile.html')


@player_bp.route('/profile/change_password', methods=['GET', 'POST'])
@login_required
def change_password():
    if request.method == 'POST':
        new_password = request.form['new_password']
        confirm_password = request.form['confirm_password']

        if new_password != confirm_password:
            flash("Passwords do not match.", "danger")
            return redirect(url_for('player.change_password'))

        conn = get_db_connection()
        cur = conn.cursor()
        try:
            cur.execute("UPDATE users SET password = %s WHERE id = %s", (new_password, session['user_id']))
            conn.commit()
            flash("Password updated successfully.", "success")
        except Exception as e:
            conn.rollback()
            flash("Error updating password: " + str(e), "danger")
        finally:
            cur.close()
            conn.close()
        return redirect(url_for('player.dashboard'))

    return render_template('change_password.html')
