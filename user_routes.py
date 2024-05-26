from flask import Blueprint, render_template, request, redirect, session, url_for, flash
from functools import wraps
from db import get_db

user_bp = Blueprint('user', __name__)

def login_required(f):
    @wraps(f)
    def wrap(*args, **kwargs):
        if 'user_id' not in session:
            flash('You need to be logged in to access this page', 'error')
            return redirect(url_for('login'))
        return f(*args, **kwargs)
    return wrap

@user_bp.route('/user')
@login_required
def user_dashboard():
    db = get_db()
    cur = db.cursor()

    cur.execute('SELECT team_id, name FROM teams')
    teams = cur.fetchall()

    cur.execute('SELECT player_id, name FROM players')
    players = cur.fetchall()

    cur.execute("""
        SELECT m.match_id, 
               t1.name AS team1_name, 
               t2.name AS team2_name, 
               COALESCE(s1.total_score, 0) AS team1_score, 
               COALESCE(s2.total_score, 0) AS team2_score,
               TO_CHAR(m.date, 'Month DD, YYYY') AS formatted_date,
               m.location
        FROM matches m
        JOIN teams t1 ON m.team1_id = t1.team_id
        JOIN teams t2 ON m.team2_id = t2.team_id
        LEFT JOIN (SELECT match_id, players.team_id, SUM(score) AS total_score 
                   FROM scores 
                   JOIN players ON scores.player_id = players.player_id
                   GROUP BY match_id, players.team_id) s1 
        ON (m.match_id = s1.match_id AND m.team1_id = s1.team_id)
        LEFT JOIN (SELECT match_id, players.team_id, SUM(score) AS total_score 
                   FROM scores 
                   JOIN players ON scores.player_id = players.player_id
                   GROUP BY match_id, players.team_id) s2 
        ON (m.match_id = s2.match_id AND m.team2_id = s2.team_id)
    """)
    matches = cur.fetchall()

    cur.close()

    return render_template('user.html', teams=teams, players=players, matches=matches)


@user_bp.route('/team/<int:team_id>')
@login_required
def profile_team(team_id):
    db = get_db()
    cur = db.cursor()

    cur.execute("""
        SELECT t.name, t.founded_year, s.name AS stadium_name, c.name AS coach_name 
        FROM teams t 
        JOIN stadiums s ON t.stadium_id = s.stadium_id 
        JOIN coaches c ON t.coach_id = c.coach_id 
        WHERE t.team_id = %s
    """, (team_id,))
    team = cur.fetchone()

    cur.execute("""
        SELECT p.player_id, p.name, p.age, p.position 
        FROM players p 
        WHERE p.team_id = %s
    """, (team_id,))
    players = cur.fetchall()

    cur.execute("""
        SELECT m.date, s.score 
        FROM scores s 
        JOIN matches m ON s.match_id = m.match_id 
        WHERE m.team1_id = %s OR m.team2_id = %s
    """, (team_id, team_id))
    scores = cur.fetchall()

    cur.close()

    if team:
        return render_template('profile_team.html', team=team, players=players, scores=scores)
    else:
        flash('Team not found', 'error')
        return redirect(url_for('user.user_dashboard'))

@user_bp.route('/player/<int:player_id>')
@login_required
def profile_player(player_id):
    db = get_db()
    cur = db.cursor()

    cur.execute("""
        SELECT p.name, p.age, p.position, t.team_id, t.name AS team_name 
        FROM players p 
        JOIN teams t ON p.team_id = t.team_id 
        WHERE p.player_id = %s
    """, (player_id,))
    player = cur.fetchone()
    cur.close()

    if player:
        return render_template('profile_player.html', player=player)
    else:
        flash('Player not found', 'error')
        return redirect(url_for('user.user_dashboard'))

@user_bp.route('/match/<int:match_id>')
@login_required
def profile_match(match_id):
    db = get_db()
    cur = db.cursor()

    cur.execute("""
        SELECT m.match_id, 
               t1.name AS team1_name, 
               t2.name AS team2_name, 
               COALESCE(s1.total_score, 0) AS team1_score, 
               COALESCE(s2.total_score, 0) AS team2_score,
               m.date, m.location
        FROM matches m
        JOIN teams t1 ON m.team1_id = t1.team_id
        JOIN teams t2 ON m.team2_id = t2.team_id
        LEFT JOIN (SELECT match_id, players.team_id, SUM(score) AS total_score 
                   FROM scores 
                   JOIN players ON scores.player_id = players.player_id
                   GROUP BY match_id, players.team_id) s1 
        ON (m.match_id = s1.match_id AND m.team1_id = s1.team_id)
        LEFT JOIN (SELECT match_id, players.team_id, SUM(score) AS total_score 
                   FROM scores 
                   JOIN players ON scores.player_id = players.player_id
                   GROUP BY match_id, players.team_id) s2 
        ON (m.match_id = s2.match_id AND m.team2_id = s2.team_id)
        WHERE m.match_id = %s
    """, (match_id,))
    match = cur.fetchone()

    cur.execute("""
        SELECT p.name, s.score
        FROM scores s
        JOIN players p ON s.player_id = p.player_id
        WHERE s.match_id = %s
    """, (match_id,))
    scores = cur.fetchall()

    cur.execute("""
        SELECT stat_type, value
        FROM game_stats
        WHERE match_id = %s
    """, (match_id,))
    game_stats = cur.fetchall()

    cur.close()

    if match:
        return render_template('profile_match.html', match=match, scores=scores, game_stats=game_stats)
    else:
        flash('Match not found', 'error')
        return redirect(url_for('user.user_dashboard'))
