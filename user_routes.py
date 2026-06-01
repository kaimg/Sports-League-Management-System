from flask import Blueprint, render_template, request, redirect, session, url_for, flash, jsonify
from functools import wraps

from db import get_db
from notification_service import notification_row_to_dict, run_notification_detection

user_bp = Blueprint('user', __name__)

def login_required(f):
    @wraps(f)
    def wrap(*args, **kwargs):
        if 'user_id' not in session:
            flash('You need to be logged in to access this page', 'error')
            return redirect(url_for('login'))
        return f(*args, **kwargs)
    return wrap


def login_required_api(f):
    @wraps(f)
    def wrap(*args, **kwargs):
        if 'user_id' not in session:
            return jsonify({"error": "Authentication required"}), 401
        return f(*args, **kwargs)
    return wrap

@user_bp.route('/user')
@login_required
def user_dashboard():
    user_id = session['user_id']
    db = get_db()
    cur = db.cursor()

    # Get favorite teams and leagues
    cur.execute("SELECT entity_id FROM user_favorites WHERE user_id = %s AND entity_type = 'team'", (user_id,))
    fav_team_ids = [row[0] for row in cur.fetchall()]

    cur.execute("SELECT entity_id FROM user_favorites WHERE user_id = %s AND entity_type = 'league'", (user_id,))
    fav_league_ids = [row[0] for row in cur.fetchall()]

    upcoming_match = None
    recent_match = None
    standings = []
    favorite_league = None

    if fav_team_ids or fav_league_ids:
        team_placeholders = ','.join(['%s'] * len(fav_team_ids)) if fav_team_ids else 'NULL'
        league_placeholders = ','.join(['%s'] * len(fav_league_ids)) if fav_league_ids else 'NULL'
        
        params = []
        if fav_team_ids:
            params.extend(fav_team_ids)
            params.extend(fav_team_ids)
        if fav_league_ids:
            params.extend(fav_league_ids)
            
        where_clause = []
        if fav_team_ids:
            where_clause.append(f"(m.home_team_id IN ({team_placeholders}) OR m.away_team_id IN ({team_placeholders}))")
        if fav_league_ids:
            where_clause.append(f"m.league_id IN ({league_placeholders})")
        where_sql = " OR ".join(where_clause)

        # 1. Upcoming match preview
        cur.execute(f"""
            SELECT m.match_id, t1.name, t2.name, TO_CHAR(m.utc_date, 'Mon DD, HH24:MI'), t1.crestURL, t2.crestURL
            FROM matches m
            JOIN teams t1 ON m.home_team_id = t1.team_id
            JOIN teams t2 ON m.away_team_id = t2.team_id
            WHERE ({where_sql}) AND m.status IN ('SCHEDULED', 'TIMED', 'POSTPONED')
            ORDER BY m.utc_date ASC LIMIT 1
        """, tuple(params))
        upcoming_match = cur.fetchone()

        # 1. Recent match preview
        cur.execute(f"""
            SELECT m.match_id, t1.name, t2.name, s.full_time_home, s.full_time_away, t1.crestURL, t2.crestURL, m.status
            FROM matches m
            JOIN teams t1 ON m.home_team_id = t1.team_id
            JOIN teams t2 ON m.away_team_id = t2.team_id
            LEFT JOIN scores s ON m.match_id = s.match_id
            WHERE ({where_sql}) AND m.status IN ('FINISHED', 'IN_PLAY', 'PAUSED')
            ORDER BY m.utc_date DESC LIMIT 1
        """, tuple(params))
        recent_match = cur.fetchone()

    # 4. Mini Standings table
    if fav_league_ids:
        fav_league_id = fav_league_ids[0]
        cur.execute("SELECT name FROM leagues WHERE league_id = %s", (fav_league_id,))
        league_row = cur.fetchone()
        if league_row:
            favorite_league = league_row[0]

        cur.execute("""
            SELECT s.position, t.name, s.played_games, s.points, t.crestURL
            FROM standings s
            JOIN teams t ON s.team_id = t.team_id
            WHERE s.league_id = %s AND s.season_id = (
                SELECT season_id FROM seasons WHERE league_id = %s ORDER BY year DESC LIMIT 1
            )
            ORDER BY s.position ASC LIMIT 5
        """, (fav_league_id, fav_league_id))
        standings = cur.fetchall()
    else:
        # Fallback to some major league, e.g. Premier League or La Liga
        cur.execute("SELECT league_id, name FROM leagues ORDER BY league_id LIMIT 1")
        default_league = cur.fetchone()
        if default_league:
            favorite_league = default_league[1]
            cur.execute("""
                SELECT s.position, t.name, s.played_games, s.points, t.crestURL
                FROM standings s
                JOIN teams t ON s.team_id = t.team_id
                WHERE s.league_id = %s AND s.season_id = (
                    SELECT season_id FROM seasons WHERE league_id = %s ORDER BY year DESC LIMIT 1
                )
                ORDER BY s.position ASC LIMIT 5
            """, (default_league[0], default_league[0]))
            standings = cur.fetchall()

    # 6. Suggestions
    if fav_team_ids:
        placeholders = ','.join(['%s']*len(fav_team_ids))
        cur.execute(f"SELECT team_id, name, crestURL FROM teams WHERE is_active = TRUE AND team_id NOT IN ({placeholders}) LIMIT 4", tuple(fav_team_ids))
    else:
        cur.execute("SELECT team_id, name, crestURL FROM teams WHERE is_active = TRUE LIMIT 4")
    suggested_teams = cur.fetchall()

    if fav_league_ids:
        placeholders = ','.join(['%s']*len(fav_league_ids))
        cur.execute(f"SELECT league_id, name, icon_url FROM leagues WHERE league_id NOT IN ({placeholders}) LIMIT 3", tuple(fav_league_ids))
    else:
        cur.execute("SELECT league_id, name, icon_url FROM leagues LIMIT 3")
    suggested_leagues = cur.fetchall()

    cur.close()

    return render_template('user_dashboard.html', 
                           upcoming_match=upcoming_match, 
                           recent_match=recent_match, 
                           favorite_league=favorite_league,
                           standings=standings,
                           suggested_teams=suggested_teams,
                           suggested_leagues=suggested_leagues,
                           has_favorites=bool(fav_team_ids or fav_league_ids))

@user_bp.route('/my-feed')
@login_required
def my_feed():
    user_id = session['user_id']
    db = get_db()
    cur = db.cursor()

    # Get favorite teams
    cur.execute("""
        SELECT t.team_id, t.name, t.crestURL 
        FROM teams t
        JOIN user_favorites uf ON t.team_id = uf.entity_id
        WHERE uf.user_id = %s AND uf.entity_type = 'team'
    """, (user_id,))
    favorite_teams = cur.fetchall()

    # Get favorite leagues
    cur.execute("""
        SELECT l.league_id, l.name, l.icon_url 
        FROM leagues l
        JOIN user_favorites uf ON l.league_id = uf.entity_id
        WHERE uf.user_id = %s AND uf.entity_type = 'league'
    """, (user_id,))
    favorite_leagues = cur.fetchall()

    # Extract IDs for filtering matches
    fav_team_ids = [team[0] for team in favorite_teams]
    fav_league_ids = [league[0] for league in favorite_leagues]

    recent_matches = []
    upcoming_matches = []

    if fav_team_ids or fav_league_ids:
        # Construct dynamic query params
        team_placeholders = ','.join(['%s'] * len(fav_team_ids)) if fav_team_ids else 'NULL'
        league_placeholders = ','.join(['%s'] * len(fav_league_ids)) if fav_league_ids else 'NULL'
        
        params = []
        if fav_team_ids:
            params.extend(fav_team_ids)
            params.extend(fav_team_ids)
        if fav_league_ids:
            params.extend(fav_league_ids)

        where_clause = []
        if fav_team_ids:
            where_clause.append(f"(m.home_team_id IN ({team_placeholders}) OR m.away_team_id IN ({team_placeholders}))")
        if fav_league_ids:
            where_clause.append(f"m.league_id IN ({league_placeholders})")
        
        where_sql = " OR ".join(where_clause)

        # Get recent matches (FINISHED)
        cur.execute(f"""
            SELECT m.match_id, t1.name AS home_name, t2.name AS away_name, 
                   s.full_time_home, s.full_time_away, 
                   TO_CHAR(m.utc_date, 'Month DD, YYYY') AS f_date,
                   t1.crestURL, t2.crestURL, m.status, l.name AS league_name
            FROM matches m
            JOIN teams t1 ON m.home_team_id = t1.team_id
            JOIN teams t2 ON m.away_team_id = t2.team_id
            JOIN leagues l ON m.league_id = l.league_id
            LEFT JOIN scores s ON m.match_id = s.match_id
            WHERE ({where_sql}) AND m.status IN ('FINISHED', 'IN_PLAY', 'PAUSED')
            ORDER BY m.utc_date DESC
            LIMIT 10
        """, tuple(params))
        recent_matches = cur.fetchall()

        # Get upcoming matches (TIMED, SCHEDULED)
        cur.execute(f"""
            SELECT m.match_id, t1.name AS home_name, t2.name AS away_name, 
                   TO_CHAR(m.utc_date, 'Month DD, YYYY HH24:MI') AS f_date,
                   t1.crestURL, t2.crestURL, m.status, l.name AS league_name
            FROM matches m
            JOIN teams t1 ON m.home_team_id = t1.team_id
            JOIN teams t2 ON m.away_team_id = t2.team_id
            JOIN leagues l ON m.league_id = l.league_id
            WHERE ({where_sql}) AND m.status IN ('SCHEDULED', 'TIMED', 'POSTPONED')
            ORDER BY m.utc_date ASC
            LIMIT 10
        """, tuple(params))
        upcoming_matches = cur.fetchall()

    cur.close()

    return render_template('my_feed.html', 
                           favorite_teams=favorite_teams, 
                           favorite_leagues=favorite_leagues,
                           recent_matches=recent_matches,
                           upcoming_matches=upcoming_matches)

@user_bp.route('/map')
@login_required
def stadiums_map():
    db = get_db()
    cur = db.cursor()

    cur.execute("""
        SELECT league_id, name, COALESCE(color, '#343a40') AS color
        FROM leagues
        ORDER BY name ASC
    """)
    leagues = cur.fetchall()

    cur.execute('SELECT DISTINCT country FROM stadiums WHERE country IS NOT NULL ORDER BY country ASC')
    countries = cur.fetchall()

    cur.execute('SELECT DISTINCT city FROM stadiums WHERE city IS NOT NULL ORDER BY city ASC')
    cities = cur.fetchall()

    cur.close()

    return render_template(
        'map.html',
        leagues=leagues,
        countries=countries,
        cities=cities
    )

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
    SELECT t.team_id, t.name, t.crestURL
    FROM teams t
    JOIN leagues l ON t.league_id = l.league_id
    WHERE t.is_active = TRUE
"""
    filters = []

    # Add filters based on the selected values
    if league_id:
        query += " AND t.league_id = %s"
        filters.append(league_id)
    if country_id:
        query += " AND l.country_id = %s"
        filters.append(country_id)
    # Add global search filter
    search = request.args.get('search')
    if search:
        query += " AND t.name ILIKE %s"
        filters.append(f"%{search}%")

    query += " LIMIT %s OFFSET %s"
    filters.append(20)
    filters.append((request.args.get('page', 1, type=int) - 1) * 20)

    cur.execute(query, filters)
    teams = cur.fetchall()

    count_query = """
        SELECT COUNT(*) 
        FROM teams t
        LEFT JOIN leagues l ON t.league_id = l.league_id
        WHERE t.is_active = TRUE
    """
    count_filters = []

    if league_id:
        count_query += " AND t.league_id = %s"
        count_filters.append(league_id)

    if country_id:
        count_query += " AND l.country_id = %s"
        count_filters.append(country_id)

    search = request.args.get('search')
    if search:
        count_query += " AND t.name ILIKE %s"
        count_filters.append(f"%{search}%")

    cur.execute(count_query, count_filters)
    total_teams_result = cur.fetchone()
    total_teams = total_teams_result[0] if total_teams_result else 0
    cur.close()

    total_pages = (total_teams + 19) // 20

    return render_template('user_teams.html', teams=teams, page=request.args.get('page', 1, type=int), total_pages=total_pages, total_teams=total_teams, leagues=leagues, countries=countries, max=max, min=min, str=str)

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
    total_players_result = cur.fetchone()
    total_players = total_players_result[0] if total_players_result else 0
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
               m.matchday,
               m.status
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
        query += """
    AND (
        t1.league_id IN (
            SELECT league_id FROM leagues WHERE country_id = %s
        )
        OR
        t2.league_id IN (
            SELECT league_id FROM leagues WHERE country_id = %s
        )
    )
    """
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
        SELECT t.name, t.founded_year, s.name AS stadium_name, c.name AS coach_name, l.name AS league_name, t.crestURL, co.flag_url, s.latitude, s.longitude, s.city, s.country
        FROM teams t 
        LEFT JOIN stadiums s ON t.stadium_id = s.stadium_id
        LEFT JOIN coaches c ON t.coach_id = c.coach_id 
        LEFT JOIN countries co ON c.nationality = co.name
        JOIN leagues l ON t.league_id = l.league_id
        WHERE t.team_id = %s
    """, (team_id,))
    team = cur.fetchone()

    # Get players
    cur.execute("""
        SELECT 
            p.player_id,
            p.name,
            p.date_of_birth,
            p.position,
            p.nationality,
            c.flag_url
        FROM players p
        LEFT JOIN countries c ON LOWER(p.nationality) = LOWER(c.name)
        WHERE p.team_id = %s
        ORDER BY p.position, p.name
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

    # Check if the user has favorited this team
    user_id = session['user_id']
    cur = get_db().cursor()
    cur.execute("SELECT id FROM user_favorites WHERE user_id = %s AND entity_type = 'team' AND entity_id = %s", (user_id, team_id))
    fav_record = cur.fetchone()
    is_favorite = True if fav_record else False
    cur.close()

    if team:
        return render_template('profile_team.html',
                               team=team,
                               players=players,
                               scores=scores,
                               logo_url=team[5],
                               team_id=team_id,
                               is_favorite=is_favorite)
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
        ORDER BY sc.season_id DESC
        LIMIT 1
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
           st.city AS stadium_city,
           st.country AS stadium_country,
           st.latitude AS stadium_latitude,
           st.longitude AS stadium_longitude,
           r.name AS referee_name,
           c.flag_url AS referee_flag_url,
           t1.team_id AS home_team_id,
           t2.team_id AS away_team_id,
           m.status
    FROM matches m
    JOIN teams t1 ON m.home_team_id = t1.team_id
    JOIN teams t2 ON m.away_team_id = t2.team_id
    LEFT JOIN scores s ON m.match_id = s.match_id
    LEFT JOIN stadiums st ON t1.stadium_id = st.stadium_id
    LEFT JOIN match_referees mr ON m.match_id = mr.match_id
    LEFT JOIN referees r ON mr.referee_id = r.referee_id
    LEFT JOIN countries c ON r.nationality = c.name
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

    cur.execute('SELECT team_id, name, cresturl FROM teams WHERE league_id = %s AND is_active = TRUE', (league_id,))
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
        WHERE s.league_id = %s AND s.season_id = (
            SELECT season_id FROM seasons
            WHERE league_id = %s
            ORDER BY year DESC
            LIMIT 1
        )
        ORDER BY s.position
    """, (league_id, league_id))
    standings = cur.fetchall()

    user_id = session['user_id']
    cur.execute("SELECT id FROM user_favorites WHERE user_id = %s AND entity_type = 'league' AND entity_id = %s", (user_id, league_id))
    fav_record = cur.fetchone()
    is_favorite = True if fav_record else False

    cur.close()

    return render_template('profile_league.html', league=league, teams=teams, standings=standings, league_id=league_id, is_favorite=is_favorite)




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
        WHERE sc.season_id IN (
            SELECT s1.season_id FROM seasons s1
            WHERE s1.year = (SELECT MAX(year) FROM seasons s2 WHERE s1.league_id = s2.league_id)
        )
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


@user_bp.route('/api/favorites', methods=['POST'])
@login_required
def add_favorite():
    data = request.get_json()

    if not data or 'entity_type' not in data or 'entity_id' not in data:
        return jsonify({"error": "Missing required fields"}), 400

    entity_type = data['entity_type']
    entity_id = data['entity_id']
    user_id = session['user_id']

    db = get_db()
    cur = db.cursor()

    try:
        cur.execute(
            """
            INSERT INTO user_favorites (user_id, entity_type, entity_id)
            VALUES (%s, %s, %s)
            RETURNING id
            """,
            (user_id, entity_type, entity_id)
        )

        fav_result = cur.fetchone()

        if fav_result is None:
            db.rollback()
            return jsonify({"error": "Could not create favorite"}), 500

        fav_id = fav_result[0]
        db.commit()

        return jsonify({"success": True, "id": fav_id}), 201

    except Exception as e:
        db.rollback()

        if "unique constraint" in str(e).lower():
            return jsonify({"error": "Already marked as favorite"}), 409

        return jsonify({"error": str(e)}), 500

    finally:
        cur.close()

@user_bp.route('/api/favorites', methods=['DELETE'])
@login_required
def remove_favorite():
    data = request.get_json()
    if not data or 'entity_type' not in data or 'entity_id' not in data:
        return jsonify({"error": "Missing required fields"}), 400
        
    entity_type = data['entity_type']
    entity_id = data['entity_id']
    user_id = session['user_id']
    
    db = get_db()
    cur = db.cursor()
    try:
        cur.execute(
            "DELETE FROM user_favorites WHERE entity_type = %s AND entity_id = %s AND user_id = %s RETURNING id",
            (entity_type, entity_id, user_id)
        )
        deleted = cur.fetchone()
        db.commit()
        if deleted:
            return jsonify({"success": True}), 200
        else:
            return jsonify({"error": "Favorite not found or unauthorized"}), 404
    except Exception as e:
        db.rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        cur.close()

@user_bp.route('/api/favorites', methods=['GET'])
@login_required
def get_favorites():
    user_id = session['user_id']
    db = get_db()
    cur = db.cursor()
    
    cur.execute(
        "SELECT id, entity_type, entity_id, created_at FROM user_favorites WHERE user_id = %s ORDER BY created_at DESC",
        (user_id,)
    )
    favorites = cur.fetchall()
    cur.close()
    
    result = []
    for fav in favorites:
        result.append({
            "id": fav[0],
            "entity_type": fav[1],
            "entity_id": fav[2],
            "created_at": fav[3].isoformat() if fav[3] else None
        })
        
    return jsonify(result), 200


def _fetch_user_notifications(user_id, unread_only=False, limit=None):
    db = get_db()
    cur = db.cursor()

    query = """
        SELECT id, type, message, related_match_id, is_read, created_at
        FROM notifications
        WHERE user_id = %s
    """
    params = [user_id]

    if unread_only:
        query += " AND is_read = FALSE"

    query += " ORDER BY created_at DESC"

    if limit is not None:
        query += " LIMIT %s"
        params.append(limit)

    cur.execute(query, tuple(params))
    rows = cur.fetchall()
    cur.close()
    return [notification_row_to_dict(row) for row in rows]


@user_bp.route('/api/notifications/detect', methods=['POST'])
@login_required_api
def trigger_notification_detection():
    """Run upcoming-match detection on demand (e.g. after login or cron)."""
    db = get_db()
    try:
        counts = run_notification_detection(db)
        return jsonify({"success": True, "created": counts}), 200
    except Exception as exc:
        return jsonify({"error": str(exc)}), 500


@user_bp.route('/api/notifications/history', methods=['GET'])
@login_required_api
def get_notification_history():
    user_id = session['user_id']
    return jsonify(_fetch_user_notifications(user_id)), 200


@user_bp.route('/api/notifications/read-all', methods=['PATCH'])
@login_required_api
def mark_all_notifications_read():
    user_id = session['user_id']
    db = get_db()
    cur = db.cursor()
    try:
        cur.execute(
            """
            UPDATE notifications
            SET is_read = TRUE
            WHERE user_id = %s AND is_read = FALSE
            RETURNING id
            """,
            (user_id,),
        )
        updated = cur.rowcount
        db.commit()
        return jsonify({"success": True, "updated": updated}), 200
    except Exception as exc:
        db.rollback()
        return jsonify({"error": str(exc)}), 500
    finally:
        cur.close()


@user_bp.route('/api/notifications/<int:notification_id>/read', methods=['PATCH'])
@login_required_api
def mark_notification_read(notification_id):
    user_id = session['user_id']
    db = get_db()
    cur = db.cursor()
    try:
        cur.execute(
            """
            UPDATE notifications
            SET is_read = TRUE
            WHERE id = %s AND user_id = %s
            RETURNING id
            """,
            (notification_id, user_id),
        )
        updated = cur.fetchone()
        db.commit()
        if not updated:
            return jsonify({"error": "Notification not found or unauthorized"}), 404
        return jsonify({"success": True, "id": notification_id}), 200
    except Exception as exc:
        db.rollback()
        return jsonify({"error": str(exc)}), 500
    finally:
        cur.close()


@user_bp.route('/api/notifications', methods=['GET'])
@login_required_api
def get_notifications():
    user_id = session['user_id']
    unread_only = request.args.get('unread_only', '').lower() in ('1', 'true', 'yes')
    limit = request.args.get('limit', type=int)

    if limit is None:
        limit = 50

    notifications = _fetch_user_notifications(user_id, unread_only=unread_only, limit=limit)

    db = get_db()
    cur = db.cursor()
    cur.execute(
        "SELECT COUNT(*) FROM notifications WHERE user_id = %s AND is_read = FALSE",
        (user_id,),
    )
    unread_result = cur.fetchone()
    unread_count = unread_result[0] if unread_result else 0

    cur.close()

    return jsonify({
        "notifications": notifications,
        "unread_count": unread_count,
    }), 200


@user_bp.route('/notifications')
@login_required
def notifications_page():
    return render_template('notifications.html')


@user_bp.route('/notifications/history')
@login_required
def notifications_history_page():
    return render_template('notifications_history.html')