from flask import Blueprint, render_template, request, redirect, session, url_for, flash
from functools import wraps
from db import get_db
import requests
from config import Config

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
    return render_template('user_dashboard.html')

@user_bp.route('/user/teams')
@login_required
def user_teams():
    db = get_db()
    cur = db.cursor()

    page = request.args.get('page', 1, type=int)
    per_page = 20
    offset = (page - 1) * per_page

    cur.execute('SELECT COUNT(*) FROM teams')
    total_teams = cur.fetchone()[0]

    cur.execute('SELECT team_id, name, crestURL FROM teams LIMIT %s OFFSET %s', (per_page, offset))
    teams = cur.fetchall()
    cur.close()

    total_pages = (total_teams + per_page - 1) // per_page

    return render_template('user_teams.html', teams=teams, page=page, total_pages=total_pages)

@user_bp.route('/user/players')
@login_required
def user_players():
    db = get_db()
    cur = db.cursor()

    page = request.args.get('page', 1, type=int)
    per_page = 20
    offset = (page - 1) * per_page

    cur.execute('SELECT COUNT(*) FROM players')
    total_players = cur.fetchone()[0]

    cur.execute('''
        SELECT p.player_id, p.name, p.position, t.crestURL, t.name, c.flag_url
        FROM players p
        JOIN teams t ON p.team_id = t.team_id
        JOIN countries c ON p.nationality = c.name
        LIMIT %s OFFSET %s
    ''', (per_page, offset))
    players = cur.fetchall()
    cur.close()

    total_pages = (total_players + per_page - 1) // per_page

    return render_template('user_players.html', players=players, page=page, total_pages=total_pages, max=max, min=min)



@user_bp.route('/user/leagues')
@login_required
def user_leagues():
    db = get_db()
    cur = db.cursor()
    cur.execute('''
        SELECT l.league_id, l.name, c.flag_url, l.icon_url
        FROM leagues l
        JOIN countries c ON l.country_id = c.country_id
    ''')
    leagues = cur.fetchall()
    cur.close()

    return render_template('user_leagues.html', leagues=leagues)
    
@user_bp.route('/user/matches')
@login_required
def user_matches():
    db = get_db()
    cur = db.cursor()
    cur.execute("""
        SELECT m.match_id, 
               t1.name AS home_team_name, 
               t2.name AS away_team_name, 
               s.full_time_home AS home_score, 
               s.full_time_away AS away_score,
               TO_CHAR(m.utc_date, 'Month DD, YYYY') AS formatted_date,
               t1.crestURL AS home_team_logo,
               t2.crestURL AS away_team_logo,
               m.matchday
        FROM matches m
        JOIN teams t1 ON m.home_team_id = t1.team_id
        JOIN teams t2 ON m.away_team_id = t2.team_id
        LEFT JOIN scores s ON m.match_id = s.match_id
        ORDER BY m.utc_date DESC
    """)
    matches = cur.fetchall()
    cur.close()
    return render_template('user_matches.html', matches=matches)


@user_bp.route('/team/<int:team_id>')
@login_required
def profile_team(team_id):
    db = get_db()
    cur = db.cursor()

    # Get team details along with stadium, coach, league, and crestURL
    cur.execute("""
        SELECT t.name, t.founded_year, s.name AS stadium_name, c.name AS coach_name, l.name AS league_name, t.crestURL
        FROM teams t 
        JOIN stadiums s ON t.stadium_id = s.stadium_id 
        JOIN coaches c ON t.coach_id = c.coach_id 
        JOIN leagues l ON t.league_id = l.league_id
        WHERE t.team_id = %s
    """, (team_id,))
    team = cur.fetchone()

    # Get players
    cur.execute("""
        SELECT p.player_id, p.name, p.date_of_birth, p.position 
        FROM players p 
        WHERE p.team_id = %s
    """, (team_id,))
    players = cur.fetchall()

    # Get scores
    cur.execute("""
        SELECT 
            m.utc_date, 
            t1.name AS home_team_name, 
            t2.name AS away_team_name, 
            s.full_time_home, 
            s.full_time_away,
            CASE 
                WHEN m.home_team_id = %s THEN s.full_time_home 
                ELSE s.full_time_away 
            END AS team_score,
            CASE 
                WHEN m.home_team_id = %s THEN s.full_time_away 
                ELSE s.full_time_home 
            END AS opponent_score,
            t1.crestURL AS home_team_logo,
            t2.crestURL AS away_team_logo,
            m.matchday
        FROM matches m
        JOIN teams t1 ON m.home_team_id = t1.team_id
        JOIN teams t2 ON m.away_team_id = t2.team_id
        LEFT JOIN scores s ON m.match_id = s.match_id
        WHERE m.home_team_id = %s OR m.away_team_id = %s
    """, (team_id, team_id, team_id, team_id))
    scores = cur.fetchall()

    cur.close()

    if team:
        return render_template('profile_team.html',
                               team=team,
                               players=players,
                               scores=scores,
                               logo_url=team[5])
    else:
        flash('Team not found', 'error')
        return redirect(url_for('user_dashboard'))



@user_bp.route('/player/<int:player_id>')
@login_required
def profile_player(player_id):
    db = get_db()
    cur = db.cursor()

    cur.execute("""
        SELECT p.name, p.date_of_birth, p.position, t.team_id, t.name AS team_name 
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
               t1.name AS home_team_name, 
               t2.name AS away_team_name, 
               s.full_time_home AS home_score, 
               s.full_time_away AS away_score,
               TO_CHAR(m.utc_date, 'Month DD, YYYY') AS formatted_date,
               m.matchday,
               t1.crestURL AS home_team_logo,
               t2.crestURL AS away_team_logo,
               st.name AS stadium_name,
               st.location AS stadium_location
        FROM matches m
        JOIN teams t1 ON m.home_team_id = t1.team_id
        JOIN teams t2 ON m.away_team_id = t2.team_id
        LEFT JOIN scores s ON m.match_id = s.match_id
        JOIN stadiums st ON t1.stadium_id = st.stadium_id
        WHERE m.match_id = %s
    """, (match_id,))
    match = cur.fetchone()

    cur.execute("""
        SELECT s.full_time_home, s.full_time_away, s.half_time_home, s.half_time_away
        FROM scores s
        WHERE s.match_id = %s
    """, (match_id,))
    scores = cur.fetchall()

    cur.close()

    if match:
        return render_template('profile_match.html', match=match, scores=scores)
    else:
        flash('Match not found', 'error')
        return redirect(url_for('user.user_dashboard'))



@user_bp.route('/league/<int:league_id>')
@login_required
def profile_league(league_id):
    db = get_db()
    cur = db.cursor()

    cur.execute("""
        SELECT l.name, c.name AS country, l.icon_url, c.flag_url
        FROM leagues l
        JOIN countries c ON l.country_id = c.country_id
        WHERE l.league_id = %s
    """, (league_id,))
    league = cur.fetchone()

    cur.execute('SELECT team_id, name FROM teams WHERE league_id = %s', (league_id,))
    teams = cur.fetchall()

    cur.execute("""
        SELECT s.position, s.team_id, t.name AS team_name, s.played_games, s.won, s.draw, s.lost, 
               s.points, s.goals_for, s.goals_against, s.goal_difference, s.form, t.crestURL
        FROM standings s
        JOIN teams t ON s.team_id = t.team_id
        WHERE s.league_id = %s
        ORDER BY s.position
    """, (league_id,))
    standings = cur.fetchall()

    cur.close()

    return render_template('profile_league.html', league=league, teams=teams, standings=standings)

@user_bp.route('/user/scorers')
@login_required
def user_scorers():
    db = get_db()
    cur = db.cursor()

    # Get filter parameters from the request
    league_id = request.args.get('league_id')
    country_id = request.args.get('country_id')
    team_id = request.args.get('team_id')

    # Fetch available leagues, countries, and teams for filtering
    cur.execute('SELECT league_id, name FROM leagues')
    leagues = cur.fetchall()

    cur.execute('SELECT country_id, name FROM countries')
    countries = cur.fetchall()

    cur.execute('SELECT team_id, name FROM teams')
    teams = cur.fetchall()

    # Build the base query
    query = """
        SELECT sc.player_id, p.name, sc.goals, sc.assists, sc.penalties, t.crestURL, p.nationality
        FROM scorers sc
        JOIN players p ON sc.player_id = p.player_id
        JOIN teams t ON p.team_id = t.team_id
        WHERE 1=1
    """
    filters = []

    # Add filters based on the selected values
    if league_id:
        query += " AND sc.league_id = %s"
        filters.append(league_id)
    if country_id:
        query += " AND p.nationality = (SELECT name FROM countries WHERE country_id = %s)"
        filters.append(country_id)
    if team_id:
        query += " AND p.team_id = %s"
        filters.append(team_id)

    query += " ORDER BY sc.goals DESC"

    cur.execute(query, filters)
    scorers = cur.fetchall()
    cur.close()

    return render_template('user_scorers.html', scorers=scorers, leagues=leagues, countries=countries, teams=teams, str=str)


