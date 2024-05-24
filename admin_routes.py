from flask import Blueprint, render_template, request, redirect, session, url_for, flash
from functools import wraps
from db import get_db

admin_bp = Blueprint('admin', __name__)

def admin_required(f):
    @wraps(f)
    def wrap(*args, **kwargs):
        if 'user_id' not in session or not session.get('is_admin'):
            flash('You need to be an admin to access this page', 'error')
            return redirect(url_for('login'))
        return f(*args, **kwargs)
    return wrap

def get_existing_data(table_name):
    db = get_db()
    cur = db.cursor()
    cur.execute(f'SELECT * FROM {table_name}')
    data = cur.fetchall()
    cur.close()
    return data

@admin_bp.route('/manage_stadiums', methods=['GET', 'POST'])
@admin_required
def manage_stadiums():
    db = get_db()
    cur = db.cursor()

    if request.method == 'POST':
        try:
            stadium_id = request.form.get('stadium_id')
            name = request.form['name']
            location = request.form['location']
            capacity = request.form['capacity']

            if 'add' in request.form:
                cur.execute('INSERT INTO stadiums (name, location, capacity) VALUES (%s, %s, %s)', 
                            (name, location, capacity))
                flash('Stadium added successfully', 'success')
            elif 'edit' in request.form and stadium_id:
                cur.execute('UPDATE stadiums SET name = %s, location = %s, capacity = %s WHERE stadium_id = %s', 
                            (name, location, capacity, stadium_id))
                flash('Stadium updated successfully', 'success')
            elif 'delete' in request.form and stadium_id:
                cur.execute('DELETE FROM stadiums WHERE stadium_id = %s', (stadium_id,))
                flash('Stadium deleted successfully', 'success')
            db.commit()
        except Exception as e:
            db.rollback()
            flash('An error occurred: ' + str(e), 'error')
        finally:
            cur.close()
        return redirect(url_for('admin.manage_stadiums'))

    cur.execute('SELECT stadium_id, name, location, capacity FROM stadiums')
    stadiums = cur.fetchall()
    cur.close()
    return render_template('manage_stadiums.html', stadiums=stadiums)

@admin_bp.route('/manage_leagues', methods=['GET', 'POST'])
@admin_required
def manage_leagues():
    db = get_db()
    cur = db.cursor()

    if request.method == 'POST':
        try:
            league_id = request.form.get('league_id')
            name = request.form['name']
            country = request.form['country']

            if 'add' in request.form:
                cur.execute('INSERT INTO leagues (name, country) VALUES (%s, %s)', 
                            (name, country))
                flash('League added successfully', 'success')
            elif 'edit' in request.form and league_id:
                cur.execute('UPDATE leagues SET name = %s, country = %s WHERE league_id = %s', 
                            (name, country, league_id))
                flash('League updated successfully', 'success')
            elif 'delete' in request.form and league_id:
                cur.execute('DELETE FROM leagues WHERE league_id = %s', (league_id,))
                flash('League deleted successfully', 'success')
            db.commit()
        except Exception as e:
            db.rollback()
            flash('An error occurred: ' + str(e), 'error')
        finally:
            cur.close()
        return redirect(url_for('admin.manage_leagues'))

    cur.execute('SELECT league_id, name, country FROM leagues')
    leagues = cur.fetchall()
    cur.close()
    return render_template('manage_leagues.html', leagues=leagues)
@admin_bp.route('/manage_seasons', methods=['GET', 'POST'])
@admin_required
def manage_seasons():
    db = get_db()
    cur = db.cursor()

    if request.method == 'POST':
        try:
            season_id = request.form.get('season_id')
            league_id = request.form['league_id']
            year = request.form['year']

            if 'add' in request.form:
                cur.execute('INSERT INTO seasons (league_id, year) VALUES (%s, %s)', 
                            (league_id, year))
                flash('Season added successfully', 'success')
            elif 'edit' in request.form and season_id:
                cur.execute('UPDATE seasons SET league_id = %s, year = %s WHERE season_id = %s', 
                            (league_id, year, season_id))
                flash('Season updated successfully', 'success')
            elif 'delete' in request.form and season_id:
                cur.execute('DELETE FROM seasons WHERE season_id = %s', (season_id,))
                flash('Season deleted successfully', 'success')
            db.commit()
        except Exception as e:
            db.rollback()
            flash('An error occurred: ' + str(e), 'error')
        finally:
            cur.close()
        return redirect(url_for('admin.manage_seasons'))

    cur.execute('SELECT season_id, league_id, year FROM seasons')
    seasons = cur.fetchall()
    cur.execute('SELECT league_id, name FROM leagues')
    leagues = cur.fetchall()
    cur.close()
    return render_template('manage_seasons.html', seasons=seasons, leagues=leagues)
@admin_bp.route('/manage_teams', methods=['GET', 'POST'])
@admin_required
def manage_teams():
    db = get_db()
    cur = db.cursor()

    if request.method == 'POST':
        try:
            team_id = request.form.get('team_id')
            name = request.form['name']
            founded_year = request.form['founded_year']
            stadium_id = request.form['stadium_id']
            league_id = request.form['league_id']
            coach_id = request.form['coach_id']

            if 'add' in request.form:
                cur.execute('INSERT INTO teams (name, founded_year, stadium_id, league_id, coach_id) VALUES (%s, %s, %s, %s, %s)', 
                            (name, founded_year, stadium_id, league_id, coach_id))
                flash('Team added successfully', 'success')
            elif 'edit' in request.form and team_id:
                cur.execute('UPDATE teams SET name = %s, founded_year = %s, stadium_id = %s, league_id = %s, coach_id = %s WHERE team_id = %s', 
                            (name, founded_year, stadium_id, league_id, coach_id, team_id))
                flash('Team updated successfully', 'success')
            elif 'delete' in request.form and team_id:
                cur.execute('DELETE FROM teams WHERE team_id = %s', (team_id,))
                flash('Team deleted successfully', 'success')
            db.commit()
        except Exception as e:
            db.rollback()
            flash('An error occurred: ' + str(e), 'error')
        finally:
            cur.close()
        return redirect(url_for('admin.manage_teams'))

    cur.execute('SELECT team_id, name, founded_year, stadium_id, league_id, coach_id FROM teams')
    teams = cur.fetchall()
    cur.execute('SELECT stadium_id, name FROM stadiums')
    stadiums = cur.fetchall()
    cur.execute('SELECT league_id, name FROM leagues')
    leagues = cur.fetchall()
    cur.execute('SELECT coach_id, name FROM coaches')
    coaches = cur.fetchall()
    cur.close()
    return render_template('manage_teams.html', teams=teams, stadiums=stadiums, leagues=leagues, coaches=coaches)


@admin_bp.route('/manage_coaches', methods=['GET', 'POST'])
@admin_required
def manage_coaches():
    db = get_db()
    cur = db.cursor()

    if request.method == 'POST':
        try:
            coach_id = request.form.get('coach_id')
            name = request.form['name']
            team_id = request.form['team_id']

            if 'add' in request.form:
                cur.execute('INSERT INTO coaches (name, team_id) VALUES (%s, %s)', 
                            (name, team_id))
                flash('Coach added successfully', 'success')
            elif 'edit' in request.form and coach_id:
                cur.execute('UPDATE coaches SET name = %s, team_id = %s WHERE coach_id = %s', 
                            (name, team_id, coach_id))
                flash('Coach updated successfully', 'success')
            elif 'delete' in request.form and coach_id:
                cur.execute('DELETE FROM coaches WHERE coach_id = %s', (coach_id,))
                flash('Coach deleted successfully', 'success')
            db.commit()
        except Exception as e:
            db.rollback()
            flash('An error occurred: ' + str(e), 'error')
        finally:
            cur.close()
        return redirect(url_for('admin.manage_coaches'))

    cur.execute('SELECT coach_id, name, team_id FROM coaches')
    coaches = cur.fetchall()
    cur.execute('SELECT team_id, name FROM teams')
    teams = cur.fetchall()
    cur.close()
    return render_template('manage_coaches.html', coaches=coaches, teams=teams)

@admin_bp.route('/manage_players', methods=['GET', 'POST'])
@admin_required
def manage_players():
    db = get_db()
    cur = db.cursor()

    if request.method == 'POST':
        try:
            player_id = request.form.get('player_id')
            team_id = request.form['team_id']
            name = request.form['name']
            age = request.form['age']
            position = request.form['position']

            if 'add' in request.form:
                cur.execute('INSERT INTO players (team_id, name, age, position) VALUES (%s, %s, %s, %s)', 
                            (team_id, name, age, position))
                flash('Player added successfully', 'success')
            elif 'edit' in request.form and player_id:
                cur.execute('UPDATE players SET team_id = %s, name = %s, age = %s, position = %s WHERE player_id = %s', 
                            (team_id, name, age, position, player_id))
                flash('Player updated successfully', 'success')
            elif 'delete' in request.form and player_id:
                cur.execute('DELETE FROM players WHERE player_id = %s', (player_id,))
                flash('Player deleted successfully', 'success')
            db.commit()
        except Exception as e:
            db.rollback()
            flash('An error occurred: ' + str(e), 'error')
        finally:
            cur.close()
        return redirect(url_for('admin.manage_players'))

    cur.execute('SELECT player_id, team_id, name, age, position FROM players')
    players = cur.fetchall()
    cur.execute('SELECT team_id, name FROM teams')
    teams = cur.fetchall()
    cur.close()
    return render_template('manage_players.html', players=players, teams=teams)

@admin_bp.route('/manage_matches', methods=['GET', 'POST'])
@admin_required
def manage_matches():
    db = get_db()
    cur = db.cursor()

    if request.method == 'POST':
        try:
            match_id = request.form.get('match_id')
            date = request.form['date']
            location = request.form['location']
            team1_id = request.form['team1_id']
            team2_id = request.form['team2_id']
            season_id = request.form['season_id']
            league_id = request.form['league_id']

            if 'add' in request.form:
                cur.execute('INSERT INTO matches (date, location, team1_id, team2_id, season_id, league_id) VALUES (%s, %s, %s, %s, %s, %s)', 
                            (date, location, team1_id, team2_id, season_id, league_id))
                flash('Match added successfully', 'success')
            elif 'edit' in request.form and match_id:
                cur.execute('UPDATE matches SET date = %s, location = %s, team1_id = %s, team2_id = %s, season_id = %s, league_id = %s WHERE match_id = %s', 
                            (date, location, team1_id, team2_id, season_id, league_id, match_id))
                flash('Match updated successfully', 'success')
            elif 'delete' in request.form and match_id:
                cur.execute('DELETE FROM matches WHERE match_id = %s', (match_id,))
                flash('Match deleted successfully', 'success')
            db.commit()
        except Exception as e:
            db.rollback()
            flash('An error occurred: ' + str(e), 'error')
        finally:
            cur.close()
        return redirect(url_for('admin.manage_matches'))

    cur.execute('SELECT match_id, date, location, team1_id, team2_id, season_id, league_id FROM matches')
    matches = cur.fetchall()
    cur.execute('SELECT team_id, name FROM teams')
    teams = cur.fetchall()
    cur.execute('SELECT season_id, year FROM seasons')
    seasons = cur.fetchall()
    cur.execute('SELECT league_id, name FROM leagues')
    leagues = cur.fetchall()
    cur.close()
    return render_template('manage_matches.html', matches=matches, teams=teams, seasons=seasons, leagues=leagues)

@admin_bp.route('/manage_results', methods=['GET', 'POST'])
@admin_required
def manage_results():
    db = get_db()
    cur = db.cursor()

    if request.method == 'POST':
        try:
            match_id = request.form.get('match_id')
            team_id = request.form['team_id']
            score = request.form['score']
            win = request.form.get('win') == 'on'
            draw = request.form.get('draw') == 'on'

            if 'add' in request.form:
                cur.execute('INSERT INTO results (match_id, team_id, score, win, draw) VALUES (%s, %s, %s, %s, %s)', 
                            (match_id, team_id, score, win, draw))
                flash('Result added successfully', 'success')
            elif 'edit' in request.form and match_id and team_id:
                cur.execute('UPDATE results SET score = %s, win = %s, draw = %s WHERE match_id = %s AND team_id = %s', 
                            (score, win, draw, match_id, team_id))
                flash('Result updated successfully', 'success')
            elif 'delete' in request.form and match_id and team_id:
                cur.execute('DELETE FROM results WHERE match_id = %s AND team_id = %s', (match_id, team_id))
                flash('Result deleted successfully', 'success')
            db.commit()
        except Exception as e:
            db.rollback()
            flash('An error occurred: ' + str(e), 'error')
        finally:
            cur.close()
        return redirect(url_for('admin.manage_results'))

    cur.execute('SELECT match_id, team_id, score, win, draw FROM results')
    results = cur.fetchall()
    cur.execute('SELECT match_id, date FROM matches')
    matches = cur.fetchall()
    cur.execute('SELECT team_id, name FROM teams')
    teams = cur.fetchall()
    cur.close()
    return render_template('manage_results.html', results=results, matches=matches, teams=teams)

@admin_bp.route('/manage_scores', methods=['GET', 'POST'])
@admin_required
def manage_scores():
    db = get_db()
    cur = db.cursor()

    if request.method == 'POST':
        try:
            match_id = request.form.get('match_id')
            player_id = request.form['player_id']
            score = request.form['score']

            if 'add' in request.form:
                cur.execute('INSERT INTO scores (match_id, player_id, score) VALUES (%s, %s, %s)', 
                            (match_id, player_id, score))
                flash('Score added successfully', 'success')
            elif 'edit' in request.form and match_id and player_id:
                cur.execute('UPDATE scores SET score = %s WHERE match_id = %s AND player_id = %s', 
                            (score, match_id, player_id))
                flash('Score updated successfully', 'success')
            elif 'delete' in request.form and match_id and player_id:
                cur.execute('DELETE FROM scores WHERE match_id = %s AND player_id = %s', (match_id, player_id))
                flash('Score deleted successfully', 'success')
            db.commit()
        except Exception as e:
            db.rollback()
            flash('An error occurred: ' + str(e), 'error')
        finally:
            cur.close()
        return redirect(url_for('admin.manage_scores'))

    cur.execute('SELECT match_id, player_id, score FROM scores')
    scores = cur.fetchall()
    cur.execute('SELECT match_id, date FROM matches')
    matches = cur.fetchall()
    cur.execute('SELECT player_id, name FROM players')
    players = cur.fetchall()
    cur.close()
    return render_template('manage_scores.html', scores=scores, matches=matches, players=players)

@admin_bp.route('/manage_game_stats', methods=['GET', 'POST'])
@admin_required
def manage_game_stats():
    db = get_db()
    cur = db.cursor()

    if request.method == 'POST':
        try:
            match_id = request.form.get('match_id')
            stat_type = request.form['stat_type']
            value = request.form['value']

            if 'add' in request.form:
                cur.execute('INSERT INTO game_stats (match_id, stat_type, value) VALUES (%s, %s, %s)', 
                            (match_id, stat_type, value))
                flash('Game stat added successfully', 'success')
            elif 'edit' in request.form and match_id and stat_type:
                cur.execute('UPDATE game_stats SET value = %s WHERE match_id = %s AND stat_type = %s', 
                            (value, match_id, stat_type))
                flash('Game stat updated successfully', 'success')
            elif 'delete' in request.form and match_id and stat_type:
                cur.execute('DELETE FROM game_stats WHERE match_id = %s AND stat_type = %s', (match_id, stat_type))
                flash('Game stat deleted successfully', 'success')
            db.commit()
        except Exception as e:
            db.rollback()
            flash('An error occurred: ' + str(e), 'error')
        finally:
            cur.close()
        return redirect(url_for('admin.manage_game_stats'))

    cur.execute('SELECT match_id, stat_type, value FROM game_stats')
    game_stats = cur.fetchall()
    cur.execute('SELECT match_id, date FROM matches')
    matches = cur.fetchall()
    cur.close()
    return render_template('manage_game_stats.html', game_stats=game_stats, matches=matches)