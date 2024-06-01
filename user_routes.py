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
    db = get_db()
    cur = db.cursor()

    cur.execute('SELECT team_id, name, crestURL FROM teams')
    teams = cur.fetchall()

    cur.execute('SELECT player_id, name, position FROM players')
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

    cur.execute('SELECT league_id, name FROM leagues')
    leagues = cur.fetchall()
    cur.close()

    leagues_with_flags = [
        (league[0], league[1], league_mapping.get(league[0], {}).get('flag_url', '')) for league in leagues
    ]

    return render_template('user.html', teams=teams, players=players, matches=matches, leagues=leagues_with_flags)


# Function to get team logo from the API
def get_team_logo(api_team_id):
    api_url = f"https://api.football-data.org/v2/teams/{api_team_id}"
    headers = {"X-Auth-Token": Config.FOOTBALL_DATA_API_KEY}
    response = requests.get(api_url, headers=headers)

    if response.status_code == 200:
        team_data = response.json()
        return team_data.get("crestUrl", "")
    else:
        print(f"Failed to get team details: {response.status_code}, {response.text}")
        return ""

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


# Mapping of internal league IDs to API league IDs and general flag URLs
league_mapping = {
    1: {'api_id': 'https://crests.football-data.org/PL.png', 'flag_url': 'https://crests.football-data.org/770.svg'},  # Premier League (England)
    2: {'api_id': 'https://crests.football-data.org/SA.png', 'flag_url': 'https://crests.football-data.org/784.svg'},  # Serie A (Italy)
    3: {'api_id': 'https://crests.football-data.org/PD.png', 'flag_url': 'https://crests.football-data.org/760.svg'},  # La Liga (Spain)
    4: {'api_id': 'https://crests.football-data.org/BL1.png', 'flag_url': 'https://crests.football-data.org/759.svg'},  # Bundesliga (Germany)
    5: {'api_id': 'https://crests.football-data.org/FL1.png', 'flag_url': 'https://crests.football-data.org/773.svg'}   # Ligue 1 (France)
}

def get_league_data(api_league_id):
    api_url = f"https://api.football-data.org/v2/competitions/{api_league_id}"
    headers = {"X-Auth-Token": Config.FOOTBALL_DATA_API_KEY}
    response = requests.get(api_url, headers=headers)
    if response.status_code == 200:
        league_data = response.json()
        league_logo = league_data.get("emblemUrl", "")
        return league_logo
    else:
        print(f"Failed to get league details: {response.status_code}, {response.text}")
        return ""


@user_bp.route('/league/<int:league_id>')
@login_required
def profile_league(league_id):
    db = get_db()
    cur = db.cursor()

    cur.execute('SELECT name, country FROM leagues WHERE league_id = %s', (league_id,))
    league = cur.fetchone()

    cur.execute('SELECT team_id, name FROM teams WHERE league_id = %s', (league_id,))
    teams = cur.fetchall()

    cur.execute("""
        SELECT s.position, s.team_id, t.name AS team_name, s.played_games, s.won, s.draw, s.lost, 
               s.points, s.goals_for, s.goals_against, s.goal_difference
        FROM standings s
        JOIN teams t ON s.team_id = t.team_id
        WHERE s.league_id = %s
        ORDER BY s.position
    """, (league_id,))
    standings = cur.fetchall()

    if league:
        api_league_id = league_mapping.get(league_id, {}).get('api_id')
        flag_url = league_mapping.get(league_id, {}).get('flag_url')
        league_logo = get_league_data(api_league_id) if api_league_id else ""
    league_logo = league_mapping[league_id]['api_id']
    country_flag = league_mapping[league_id]['flag_url']

    cur.close()

    return render_template('profile_league.html', league=league, teams=teams, standings=standings, league_logo=league_logo, country_flag=country_flag)