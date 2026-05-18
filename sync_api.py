import requests
import time
from config import Config
from db import get_db

LEAGUE_MAP = {
    'PL': 1, # Premier League
    'PD': 3, # La Liga
    'SA': 2, # Serie A
    'BL1': 4, # Bundesliga
    'FL1': 5 # Ligue 1
}

BASE_URL = "https://api.football-data.org/v4"

def get_headers():
    return {'X-Auth-Token': Config.FOOTBALL_DATA_API_KEY}

def get_or_create_season(cur, league_id, start_date, end_date):
    year_str = f"{start_date[:4]}-{end_date[:4]}"
    if start_date[:4] == end_date[:4]:
        year_str = start_date[:4]
        
    cur.execute("SELECT season_id FROM seasons WHERE league_id = %s AND year = %s", (league_id, year_str))
    result = cur.fetchone()
    if result:
        return result[0]
    
    # Create new season
    cur.execute("INSERT INTO seasons (league_id, year) VALUES (%s, %s) RETURNING season_id", (league_id, year_str))
    new_season_id = cur.fetchone()[0]
    return new_season_id

def sync_matches_for_league(league_code):
    """Fetches matches for a league and updates the database."""
    if not Config.FOOTBALL_DATA_API_KEY:
        return {"error": "API key not found"}
        
    url = f"{BASE_URL}/competitions/{league_code}/matches"
    response = requests.get(url, headers=get_headers())
    
    if response.status_code != 200:
        return {"error": f"API returned {response.status_code}"}
        
    data = response.json()
    matches = data.get('matches', [])
    
    if not matches:
        return {"success": 0, "error": "No matches found in API response"}
        
    league_id = LEAGUE_MAP.get(league_code)
    if not league_id:
        return {"error": "Invalid league code"}
        
    db = get_db()
    cur = db.cursor()
    
    updated_count = 0
    try:
        for match in matches:
            match_id = match['id']
            utc_date = match['utcDate']
            status = match['status']
            matchday = match.get('matchday')
            home_team_id = match['homeTeam']['id']
            away_team_id = match['awayTeam']['id']
            winner = match['score'].get('winner')
            
            # Get or create season
            season_info = match.get('season')
            if season_info:
                season_id = get_or_create_season(cur, league_id, season_info['startDate'], season_info['endDate'])
            else:
                season_id = None
                
            # Upsert match
            cur.execute("SELECT match_id FROM matches WHERE match_id = %s", (match_id,))
            if cur.fetchone():
                cur.execute("""
                    UPDATE matches 
                    SET utc_date = %s, matchday = %s, home_team_id = %s, away_team_id = %s, winner = %s, season_id = %s
                    WHERE match_id = %s
                """, (utc_date, matchday, home_team_id, away_team_id, winner, season_id, match_id))
            else:
                # Need to handle potential missing teams gracefully, but assuming API team IDs match our DB
                cur.execute("""
                    INSERT INTO matches (match_id, season_id, league_id, matchday, home_team_id, away_team_id, winner, utc_date)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
                    ON CONFLICT (match_id) DO NOTHING
                """, (match_id, season_id, league_id, matchday, home_team_id, away_team_id, winner, utc_date))
                
            # Upsert scores
            full_home = match['score']['fullTime'].get('home')
            full_away = match['score']['fullTime'].get('away')
            half_home = match['score']['halfTime'].get('home')
            half_away = match['score']['halfTime'].get('away')
            
            cur.execute("SELECT score_id FROM scores WHERE match_id = %s", (match_id,))
            score_record = cur.fetchone()
            
            if score_record:
                cur.execute("""
                    UPDATE scores 
                    SET full_time_home = %s, full_time_away = %s, half_time_home = %s, half_time_away = %s
                    WHERE match_id = %s
                """, (full_home, full_away, half_home, half_away, match_id))
            else:
                cur.execute("""
                    INSERT INTO scores (match_id, full_time_home, full_time_away, half_time_home, half_time_away)
                    VALUES (%s, %s, %s, %s, %s)
                """, (match_id, full_home, full_away, half_home, half_away))
                
            updated_count += 1
            
        db.commit()
    except Exception as e:
        db.rollback()
        return {"error": str(e)}
    finally:
        cur.close()
        
    return {"success": updated_count}

def sync_teams_for_league(league_code):
    if not Config.FOOTBALL_DATA_API_KEY:
        return {"error": "API key not found"}
        
    url = f"{BASE_URL}/competitions/{league_code}/teams"
    response = requests.get(url, headers=get_headers())
    if response.status_code != 200:
        return {"error": f"API returned {response.status_code}"}
        
    teams = response.json().get('teams', [])
    if not teams:
        return {"success": 0}
        
    league_id = LEAGUE_MAP.get(league_code)
    db = get_db()
    cur = db.cursor()
    updated_count = 0
    
    try:
        # Deactivate all teams for this league before syncing
        cur.execute("UPDATE teams SET is_active = FALSE WHERE league_id = %s", (league_id,))
        
        for team in teams:
            team_id = team['id']
            name = team['name']
            founded = team.get('founded')
            
            # Upsert coach if present
            coach_id = None
            coach = team.get('coach')
            if coach and coach.get('id'):
                coach_id = coach['id']
                coach_name = coach.get('name', 'Unknown')
                coach_nat = coach.get('nationality', 'Unknown')
                
                cur.execute("SELECT coach_id FROM coaches WHERE coach_id = %s", (coach_id,))
                if cur.fetchone():
                    cur.execute("UPDATE coaches SET name = %s, nationality = %s, team_id = %s WHERE coach_id = %s",
                                (coach_name, coach_nat, team_id, coach_id))
                else:
                    # Some foreign keys might fail if team doesn't exist yet, we insert coach without team_id first, or defer
                    cur.execute("""
                        INSERT INTO coaches (coach_id, name, nationality) VALUES (%s, %s, %s)
                        ON CONFLICT (coach_id) DO NOTHING
                    """, (coach_id, coach_name, coach_nat))
            
            cur.execute("SELECT team_id FROM teams WHERE team_id = %s", (team_id,))
            if cur.fetchone():
                cur.execute("UPDATE teams SET name = %s, founded_year = %s, league_id = %s, coach_id = %s, is_active = TRUE WHERE team_id = %s",
                            (name, founded, league_id, coach_id, team_id))
            else:
                cur.execute("INSERT INTO teams (team_id, name, founded_year, league_id, coach_id, is_active) VALUES (%s, %s, %s, %s, %s, TRUE)",
                            (team_id, name, founded, league_id, coach_id))
            
            # If coach was inserted without team_id, update it now
            if coach_id:
                cur.execute("UPDATE coaches SET team_id = %s WHERE coach_id = %s", (team_id, coach_id))
                
            updated_count += 1
            
        db.commit()
    except Exception as e:
        db.rollback()
        return {"error": str(e)}
    finally:
        cur.close()
        
    return {"success": updated_count}

def sync_scorers_for_league(league_code):
    if not Config.FOOTBALL_DATA_API_KEY:
        return {"error": "API key not found"}
        
    url = f"{BASE_URL}/competitions/{league_code}/scorers"
    response = requests.get(url, headers=get_headers())
    if response.status_code != 200:
        return {"error": f"API returned {response.status_code}"}
        
    data = response.json()
    scorers = data.get('scorers', [])
    if not scorers:
        return {"success": 0}
        
    league_id = LEAGUE_MAP.get(league_code)
    db = get_db()
    cur = db.cursor()
    updated_count = 0
    
    try:
        season_info = data.get('season')
        season_id = None
        if season_info:
            season_id = get_or_create_season(cur, league_id, season_info['startDate'], season_info['endDate'])
            
        # Optional: clear existing top scorers for this season/league to refresh, or just upsert.
        # It's easier to upsert based on player_id and season_id.
        for scorer in scorers:
            player = scorer['player']
            player_id = player['id']
            team_id = scorer['team']['id']
            
            # Ensure player exists
            cur.execute("SELECT player_id FROM players WHERE player_id = %s", (player_id,))
            if not cur.fetchone():
                cur.execute("""
                    INSERT INTO players (player_id, team_id, name, nationality)
                    VALUES (%s, %s, %s, %s)
                """, (player_id, team_id, player['name'], player.get('nationality')))
            else:
                cur.execute("UPDATE players SET team_id = %s WHERE player_id = %s", (team_id, player_id))
                
            goals = scorer.get('goals', 0)
            assists = scorer.get('assists', 0)
            penalties = scorer.get('penalties', 0)
            
            cur.execute("SELECT scorer_id FROM scorers WHERE player_id = %s AND season_id = %s", (player_id, season_id))
            record = cur.fetchone()
            if record:
                cur.execute("""
                    UPDATE scorers SET goals = %s, assists = %s, penalties = %s WHERE scorer_id = %s
                """, (goals, assists, penalties, record[0]))
            else:
                cur.execute("""
                    INSERT INTO scorers (player_id, season_id, league_id, goals, assists, penalties)
                    VALUES (%s, %s, %s, %s, %s, %s)
                """, (player_id, season_id, league_id, goals, assists, penalties))
                
            updated_count += 1
            
        db.commit()
    except Exception as e:
        db.rollback()
        return {"error": str(e)}
    finally:
        cur.close()
        
    return {"success": updated_count}

def sync_standings_for_league(league_code):
    """Fetches standings for a league and updates the database."""
    if not Config.FOOTBALL_DATA_API_KEY:
        return {"error": "API key not found"}
        
    url = f"{BASE_URL}/competitions/{league_code}/standings"
    response = requests.get(url, headers=get_headers())
    if response.status_code != 200:
        return {"error": f"API returned {response.status_code}"}
        
    data = response.json()
    standings = data.get('standings', [])
    if not standings:
        return {"success": 0, "error": "No standings found in API response"}
        
    # We only want the TOTAL standings table, which is usually the first item
    total_standings = next((s for s in standings if s['type'] == 'TOTAL'), None)
    if not total_standings:
        return {"success": 0, "error": "TOTAL standings not found"}
        
    league_id = LEAGUE_MAP.get(league_code)
    db = get_db()
    cur = db.cursor()
    updated_count = 0
    
    try:
        season_info = data.get('season')
        season_id = None
        if season_info:
            season_id = get_or_create_season(cur, league_id, season_info['startDate'], season_info['endDate'])
            
        for row in total_standings['table']:
            position = row['position']
            team_id = row['team']['id']
            played = row['playedGames']
            won = row['won']
            draw = row['draw']
            lost = row['lost']
            points = row['points']
            gf = row['goalsFor']
            ga = row['goalsAgainst']
            gd = row['goalDifference']
            form = list(row['form']) if row.get('form') else [] # e.g. "WWDLW" -> ['W','W','D','L','W']
            
            cur.execute("SELECT standing_id FROM standings WHERE season_id = %s AND team_id = %s", (season_id, team_id))
            record = cur.fetchone()
            if record:
                cur.execute("""
                    UPDATE standings 
                    SET position = %s, played_games = %s, won = %s, draw = %s, lost = %s, 
                        points = %s, goals_for = %s, goals_against = %s, goal_difference = %s, form = %s
                    WHERE standing_id = %s
                """, (position, played, won, draw, lost, points, gf, ga, gd, form, record[0]))
            else:
                cur.execute("""
                    INSERT INTO standings (season_id, league_id, position, team_id, played_games, won, draw, lost, points, goals_for, goals_against, goal_difference, form)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                """, (season_id, league_id, position, team_id, played, won, draw, lost, points, gf, ga, gd, form))
            
            updated_count += 1
            
        db.commit()
    except Exception as e:
        db.rollback()
        return {"error": str(e)}
    finally:
        cur.close()
        
    return {"success": updated_count}

def sync_all_data(app):
    """
    Global sync orchestrator running in background thread.
    Synchronizes teams, matches, scorers, and standings for all 5 major leagues
    with 6.5s delays to respect the 10 req/min API limit.
    """
    with app.app_context():
        try:
            leagues = ['PL', 'PD', 'SA', 'BL1', 'FL1']
            results = {
                "teams": {"success": 0, "errors": []},
                "matches": {"success": 0, "errors": []},
                "scorers": {"success": 0, "errors": []},
                "standings": {"success": 0, "errors": []}
            }
            
            # 1. Sync Teams (Dependencies: None)
            for league in leagues:
                res = sync_teams_for_league(league)
                if "error" in res:
                    results["teams"]["errors"].append(f"{league}: {res['error']}")
                else:
                    results["teams"]["success"] += res.get("success", 0)
                time.sleep(6.5) # Wait to respect 10 req/min limit
                    
            # 2. Sync Matches (Dependencies: Teams)
            for league in leagues:
                res = sync_matches_for_league(league)
                if "error" in res:
                    results["matches"]["errors"].append(f"{league}: {res['error']}")
                else:
                    results["matches"]["success"] += res.get("success", 0)
                time.sleep(6.5)
                    
            # 3. Sync Scorers (Dependencies: Teams)
            for league in leagues:
                res = sync_scorers_for_league(league)
                if "error" in res:
                    results["scorers"]["errors"].append(f"{league}: {res['error']}")
                else:
                    results["scorers"]["success"] += res.get("success", 0)
                time.sleep(6.5)
                
            # 4. Sync Standings (Dependencies: Teams)
            for league in leagues:
                res = sync_standings_for_league(league)
                if "error" in res:
                    results["standings"]["errors"].append(f"{league}: {res['error']}")
                else:
                    results["standings"]["success"] += res.get("success", 0)
                time.sleep(6.5)
                
            # Store results in config for flash message reading if desired
            app.config['SYNC_RESULTS'] = results
            return results
        finally:
            # Ensure the lock is always released
            app.config['SYNC_IN_PROGRESS'] = False
