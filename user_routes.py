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
    return render_template('user_dashboard.html')

@user_bp.route('/user/teams')
@login_required
def user_teams():
    db = get_db()
    cur = db.cursor()

    # Get filter parameters from the request
    league_id = request.args.get('league_id')
    country_id = request.args.get('country_id')

    # Fetch available leagues and countries for filtering
    cur.execute('SELECT league_id, name FROM leagues')
    leagues = cur.fetchall()

    cur.execute('SELECT country_id, name FROM countries ORDER BY country_id ASC')
    countries = cur.fetchall()

    # Build the base query
    query = """
        SELECT team_id, name, crestURL 
        FROM teams
        WHERE 1=1
    """
    filters = []

    # Add filters based on the selected values
    if league_id:
        query += " AND league_id = %s"
        filters.append(league_id)
    if country_id:
        query += " AND nationality = (SELECT name FROM countries WHERE country_id = %s)"
        filters.append(country_id)

    query += " LIMIT %s OFFSET %s"
    filters.append(20)
    filters.append((request.args.get('page', 1, type=int) - 1) * 20)

    cur.execute(query, filters)
    teams = cur.fetchall()

    cur.execute('SELECT COUNT(*) FROM teams WHERE 1=1 ' + (' AND league_id = %s' if league_id else '') + (' AND nationality = (SELECT name FROM countries WHERE country_id = %s)' if country_id else ''), filters[:-2])
    total_teams = cur.fetchone()[0]
    cur.close()

    total_pages = (total_teams + 19) // 20

    return render_template('user_teams.html', teams=teams, page=request.args.get('page', 1, type=int), total_pages=total_pages, leagues=leagues, countries=countries, max=max, min=min, str=str)

@user_bp.route('/user/players')
@login_required
def user_players():
    db = get_db()
    cur = db.cursor()

    page = request.args.get('page', 1, type=int)
    per_page = 20
    offset = (page - 1) * per_page

    # Get filter parameters from the request
    league_id = request.args.get('league_id')
    country_id = request.args.get('country_id')
    team_id = request.args.get('team_id')
    position = request.args.get('position')

    # Fetch available leagues, countries, teams, and positions for filtering
    cur.execute('SELECT league_id, name FROM leagues')
    leagues = cur.fetchall()

    cur.execute('SELECT country_id, name FROM countries ORDER BY country_id ASC')
    countries = cur.fetchall()

    cur.execute('SELECT team_id, name FROM teams')
    teams = cur.fetchall()

    positions = ['Goalkeeper', 'Defence', 'Midfield', 'Offence']

    # Build the base query
    query = """
        SELECT p.player_id, p.name, p.position, t.crestURL, t.name, c.flag_url
        FROM players p
        JOIN teams t ON p.team_id = t.team_id
        JOIN countries c ON p.nationality = c.name
        WHERE 1=1
    """
    filters = []

    # Add filters based on the selected values
    if league_id:
        query += " AND t.league_id = %s"
        filters.append(league_id)
    if country_id:
        query += " AND c.country_id = %s"
        filters.append(country_id)
    if team_id:
        query += " AND p.team_id = %s"
        filters.append(team_id)
    if position:
        query += " AND p.position = %s"
        filters.append(position)

    query += " LIMIT %s OFFSET %s"
    filters.append(per_page)
    filters.append(offset)

    cur.execute(query, filters)
    players = cur.fetchall()

    cur.execute('SELECT COUNT(*) FROM players p JOIN teams t ON p.team_id = t.team_id JOIN countries c ON p.nationality = c.name WHERE 1=1' + (' AND t.league_id = %s' if league_id else '') + (' AND c.country_id = %s' if country_id else '') + (' AND p.team_id = %s' if team_id else '') + (' AND p.position = %s' if position else ''), filters[:-2])
    total_players = cur.fetchone()[0]
    cur.close()

    total_pages = (total_players + per_page - 1) // per_page

    return render_template('user_players.html', players=players, page=page, total_pages=total_pages, leagues=leagues, countries=countries, teams=teams, positions=positions, max=max, min=min, str=str)




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

    # Get filter parameters from the request
    league_id = request.args.get('league_id')
    country_id = request.args.get('country_id')
    team_id = request.args.get('team_id')
    matchday = request.args.get('matchday')

    # Fetch available leagues, countries, and teams for filtering
    cur.execute('SELECT league_id, name FROM leagues')
    leagues = cur.fetchall()

    cur.execute('SELECT country_id, name FROM countries')
    countries = cur.fetchall()

    cur.execute('SELECT team_id, name FROM teams')
    teams = cur.fetchall()

    matchdays = [i for i in range(1, 39)]  # Assuming matchdays from 1 to 38

    # Build the base query
    query = """
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
        WHERE 1=1
    """
    filters = []

    # Add filters based on the selected values
    if league_id:
        query += " AND m.league_id = %s"
        filters.append(league_id)
    if country_id:
        query += " AND (t1.country_id = %s OR t2.country_id = %s)"
        filters.append(country_id)
        filters.append(country_id)
    if team_id:
        query += " AND (m.home_team_id = %s OR m.away_team_id = %s)"
        filters.append(team_id)
        filters.append(team_id)
    if matchday:
        query += " AND m.matchday = %s"
        filters.append(matchday)

    query += " ORDER BY m.utc_date DESC"

    cur.execute(query, filters)
    matches = cur.fetchall()
    cur.close()

    return render_template('user_matches.html', matches=matches, leagues=leagues, countries=countries, teams=teams, matchdays=matchdays, str=str)



@user_bp.route('/team/<int:team_id>')
@login_required
def profile_team(team_id):
    db = get_db()
    cur = db.cursor()

    # Get team details along with stadium, coach, league, and crestURL
    cur.execute("""
        SELECT t.name, t.founded_year, s.name AS stadium_name, c.name AS coach_name, l.name AS league_name, t.crestURL, co.flag_url
        FROM teams t 
        JOIN stadiums s ON t.stadium_id = s.stadium_id 
        JOIN coaches c ON t.coach_id = c.coach_id 
        JOIN countries co ON c.nationality = co.name
        JOIN leagues l ON t.league_id = l.league_id
        WHERE t.team_id = %s
    """, (team_id,))
    team = cur.fetchone()

    # Get players
    cur.execute("""
        SELECT p.player_id, p.name, p.date_of_birth, p.position, p.nationality, c.flag_url
        FROM players p 
        JOIN countries c ON p.nationality = c.name
        WHERE p.team_id = %s
    """, (team_id,))
    players = cur.fetchall()

    # Get match scores
    cur.execute("""
        SELECT 
            m.match_id,
            TO_CHAR(m.utc_date, 'Mon, DD YYYY') AS utc_date, 
            t1.name AS home_team_name, 
            t2.name AS away_team_name, 
            s.full_time_home, 
            s.full_time_away,
            t1.crestURL AS home_team_logo,
            t2.crestURL AS away_team_logo,
            m.matchday
        FROM matches m
        JOIN teams t1 ON m.home_team_id = t1.team_id
        JOIN teams t2 ON m.away_team_id = t2.team_id
        LEFT JOIN scores s ON m.match_id = s.match_id
        WHERE m.home_team_id = %s OR m.away_team_id = %s
        ORDER BY m.utc_date DESC
    """, (team_id, team_id))
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
        return redirect(url_for('user.user_dashboard'))




@user_bp.route('/player/<int:player_id>')
@login_required
def profile_player(player_id):
    db = get_db()
    cur = db.cursor()

    # Fetch player details
    cur.execute("""
        SELECT p.name, p.date_of_birth, p.position, t.team_id, t.name AS team_name, c.flag_url, c.name AS nationality
        FROM players p 
        JOIN teams t ON p.team_id = t.team_id 
        JOIN countries c ON p.nationality = c.name
        WHERE p.player_id = %s
    """, (player_id,))
    player = cur.fetchone()

    # Fetch player statistics if they are in the top scorers list
    cur.execute("""
        SELECT sc.goals, sc.assists, sc.penalties
        FROM scorers sc
        WHERE sc.player_id = %s
    """, (player_id,))
    statistics = cur.fetchone()

    cur.close()

    if player:
        return render_template('profile_player.html', player=player, statistics=statistics)
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
               st.location AS stadium_location,
               r.name AS referee_name,
               c.flag_url AS referee_flag_url,
               t1.team_id AS home_team_id,
               t2.team_id AS away_team_id
        FROM matches m
        JOIN teams t1 ON m.home_team_id = t1.team_id
        JOIN teams t2 ON m.away_team_id = t2.team_id
        LEFT JOIN scores s ON m.match_id = s.match_id
        JOIN stadiums st ON t1.stadium_id = st.stadium_id
        JOIN match_referees mr ON m.match_id = mr.match_id
        JOIN referees r ON mr.referee_id = r.referee_id
        JOIN countries c ON r.nationality = c.name
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
        SELECT l.name, c.name AS country, l.icon_url, c.flag_url, l.cl_spot, l.uel_spot, l.relegation_spot
        FROM leagues l
        JOIN countries c ON l.country_id = c.country_id
        WHERE l.league_id = %s
    """, (league_id,))
    league = cur.fetchone()

    cur.execute('SELECT team_id, name, cresturl FROM teams WHERE league_id = %s', (league_id,))
    teams = cur.fetchall()

    cur.execute("""
        SELECT s.position, s.team_id, t.name AS team_name, s.played_games, s.won, s.draw, s.lost, 
               s.points, s.goals_for, s.goals_against, s.goal_difference, s.form, t.crestURL,
               CASE WHEN s.position <= l.cl_spot THEN TRUE ELSE FALSE END AS cl_spot,
               CASE WHEN s.position > l.cl_spot AND s.position <= l.uel_spot THEN TRUE ELSE FALSE END AS uel_spot,
               CASE WHEN s.position >= l.relegation_spot THEN TRUE ELSE FALSE END AS relegation_spot
        FROM standings s
        JOIN teams t ON s.team_id = t.team_id
        JOIN leagues l ON s.league_id = l.league_id
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

    cur.execute('SELECT country_id, name FROM countries ORDER BY country_id ASC')
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


