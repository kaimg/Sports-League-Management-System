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

    cur.close()

    return render_template('user.html', teams=teams, players=players)

@user_bp.route('/team/<int:team_id>')
@login_required
def profile_team(team_id):
    db = get_db()
    cur = db.cursor()

    # Get team details along with stadium and coach
    cur.execute("""
        SELECT t.name, t.founded_year, s.name AS stadium_name, c.name AS coach_name 
        FROM teams t 
        JOIN stadiums s ON t.stadium_id = s.stadium_id 
        JOIN coaches c ON t.coach_id = c.coach_id 
        WHERE t.team_id = %s
    """, (team_id, ))
    team = cur.fetchone()

    # Get players
    cur.execute("""
        SELECT p.player_id, p.name, p.age, p.position 
        FROM players p 
        WHERE p.team_id = %s
    """, (team_id, ))
    players = cur.fetchall()

    # Get scores
    cur.execute("""
        SELECT m.date, s.score 
        FROM scores s 
        JOIN matches m ON s.match_id = m.match_id 
        WHERE m.team1_id = %s OR m.team2_id = %s
    """, (team_id, team_id))
    scores = cur.fetchall()

    cur.close()

    if team:
        return render_template('profile_team.html',
                               team=team,
                               players=players,
                               scores=scores)
    else:
        flash('Team not found', 'error')
        return redirect(url_for('search'))

@user_bp.route('/player/<int:player_id>')
@login_required
def profile_player(player_id):
    db = get_db()
    cur = db.cursor()

    # Get player details along with team
    cur.execute("""
        SELECT p.name, p.age, p.position, t.team_id, t.name AS team_name 
        FROM players p 
        JOIN teams t ON p.team_id = t.team_id 
        WHERE p.player_id = %s
    """, (player_id, ))
    player = cur.fetchone()
    cur.close()

    if player:
        return render_template('profile_player.html', player=player)
    else:
        flash('Player not found', 'error')
        return redirect(url_for('search'))
