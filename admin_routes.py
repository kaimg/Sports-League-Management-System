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

@admin_bp.route('/add_stadium', methods=['GET', 'POST'])
@admin_required
def add_stadium():
    db = get_db()
    if request.method == 'POST':
        try:
            cur = db.cursor()
            name = request.form['name']
            location = request.form['location']
            capacity = request.form['capacity']
            cur.execute('INSERT INTO stadiums (name, location, capacity) VALUES (%s, %s, %s)', 
                        (name, location, capacity))
            db.commit()
            cur.close()
            flash('Stadium added successfully', 'success')
            return redirect(url_for('admin.add_stadium'))
        except Exception as e:
            db.rollback()
            print("Error: ", str(e))
            flash('Failed to add stadium', 'error')
            return redirect(url_for('admin.add_stadium'))

    cur = db.cursor()
    cur.execute('SELECT stadium_id, name, location, capacity FROM stadiums')
    stadiums = cur.fetchall()
    cur.close()
    return render_template('add_stadium.html', stadiums=stadiums)

@admin_bp.route('/delete_stadium/<int:stadium_id>', methods=['POST'])
@admin_required
def delete_stadium(stadium_id):
    db = get_db()
    try:
        cur = db.cursor()
        cur.execute('DELETE FROM stadiums WHERE stadium_id = %s', (stadium_id,))
        db.commit()
        cur.close()
        flash('Stadium deleted successfully', 'success')
    except Exception as e:
        db.rollback()
        print("Error: ", str(e))
        flash('Failed to delete stadium', 'error')
    return redirect(url_for('admin.add_stadium'))


@admin_bp.route('/add_league', methods=['GET', 'POST'])
@admin_required
def add_league():
    db = get_db()
    if request.method == 'POST':
        try:
            cur = db.cursor()
            name = request.form['name']
            country = request.form['country']
            cur.execute('INSERT INTO leagues (name, country) VALUES (%s, %s)', 
                        (name, country))
            db.commit()
            cur.close()
            flash('League added successfully', 'success')
            return redirect(url_for('admin.add_league'))
        except Exception as e:
            db.rollback()
            print("Error: ", str(e))
            flash('Failed to add league', 'error')
            return redirect(url_for('admin.add_league'))

    cur = db.cursor()
    cur.execute('SELECT name, country FROM leagues')
    leagues = cur.fetchall()
    cur.close()
    return render_template('add_league.html', leagues=leagues)

@admin_bp.route('/add_season', methods=['GET', 'POST'])
@admin_required
def add_season():
    db = get_db()
    if request.method == 'POST':
        try:
            cur = db.cursor()
            league_id = request.form['league_id']
            year = request.form['year']
            cur.execute('INSERT INTO seasons (league_id, year) VALUES (%s, %s)', 
                        (league_id, year))
            db.commit()
            cur.close()
            flash('Season added successfully', 'success')
            return redirect(url_for('admin.add_season'))
        except Exception as e:
            db.rollback()
            print("Error: ", str(e))
            flash('Failed to add season', 'error')
            return redirect(url_for('admin.add_season'))

    cur = db.cursor()
    cur.execute('SELECT league_id, year FROM seasons')
    seasons = cur.fetchall()
    cur.close()
    return render_template('add_season.html', seasons=seasons)

@admin_bp.route('/add_team', methods=['GET', 'POST'])
@admin_required
def add_team():
    db = get_db()
    if request.method == 'POST':
        try:
            cur = db.cursor()
            name = request.form['name']
            manager = request.form['manager']
            founded_year = request.form['founded_year']
            stadium_id = request.form['stadium_id']
            league_id = request.form['league_id']
            cur.execute('INSERT INTO teams (name, manager, founded_year, stadium_id, league_id) VALUES (%s, %s, %s, %s, %s)', 
                        (name, manager, founded_year, stadium_id, league_id))
            db.commit()
            cur.close()
            flash('Team added successfully', 'success')
            return redirect(url_for('admin.add_team'))
        except Exception as e:
            db.rollback()
            print("Error: ", str(e))
            flash('Failed to add team', 'error')
            return redirect(url_for('admin.add_team'))

    cur = db.cursor()
    cur.execute('SELECT name, manager, founded_year, stadium_id, league_id FROM teams')
    teams = cur.fetchall()
    cur.close()
    return render_template('add_team.html', teams=teams)

@admin_bp.route('/add_coach', methods=['GET', 'POST'])
@admin_required
def add_coach():
    db = get_db()
    if request.method == 'POST':
        try:
            cur = db.cursor()
            name = request.form['name']
            team_id = request.form['team_id']
            cur.execute('INSERT INTO coaches (name, team_id) VALUES (%s, %s)', 
                        (name, team_id))
            db.commit()
            cur.close()
            flash('Coach added successfully', 'success')
            return redirect(url_for('admin.add_coach'))
        except Exception as e:
            db.rollback()
            print("Error: ", str(e))
            flash('Failed to add coach', 'error')
            return redirect(url_for('admin.add_coach'))

    cur = db.cursor()
    cur.execute('SELECT name, team_id FROM coaches')
    coaches = cur.fetchall()
    cur.close()
    return render_template('add_coach.html', coaches=coaches)

@admin_bp.route('/add_player', methods=['GET', 'POST'])
@admin_required
def add_player():
    db = get_db()
    if request.method == 'POST':
        try:
            cur = db.cursor()
            team_id = request.form['team_id']
            name = request.form['name']
            age = request.form['age']
            position = request.form['position']
            cur.execute('INSERT INTO players (team_id, name, age, position) VALUES (%s, %s, %s, %s)', 
                        (team_id, name, age, position))
            db.commit()
            cur.close()
            flash('Player added successfully', 'success')
            return redirect(url_for('admin.add_player'))
        except Exception as e:
            db.rollback()
            print("Error: ", str(e))
            flash('Failed to add player', 'error')
            return redirect(url_for('admin.add_player'))

    cur = db.cursor()
    cur.execute('SELECT team_id, name, age, position FROM players')
    players = cur.fetchall()
    cur.close()
    return render_template('add_player.html', players=players)

@admin_bp.route('/add_match', methods=['GET', 'POST'])
@admin_required
def add_match():
    db = get_db()
    if request.method == 'POST':
        try:
            cur = db.cursor()
            date = request.form['date']
            location = request.form['location']
            team1_id = request.form['team1_id']
            team2_id = request.form['team2_id']
            season_id = request.form['season_id']
            league_id = request.form['league_id']
            cur.execute('INSERT INTO matches (date, location, team1_id, team2_id, season_id, league_id) VALUES (%s, %s, %s, %s, %s, %s)', 
                        (date, location, team1_id, team2_id, season_id, league_id))
            db.commit()
            cur.close()
            flash('Match added successfully', 'success')
            return redirect(url_for('admin.add_match'))
        except Exception as e:
            db.rollback()
            print("Error: ", str(e))
            flash('Failed to add match', 'error')
            return redirect(url_for('admin.add_match'))

    cur = db.cursor()
    cur.execute('SELECT date, location, team1_id, team2_id, season_id, league_id FROM matches')
    matches = cur.fetchall()
    cur.close()
    return render_template('add_match.html', matches=matches)

@admin_bp.route('/add_result', methods=['GET', 'POST'])
@admin_required
def add_result():
    db = get_db()
    if request.method == 'POST':
        try:
            cur = db.cursor()
            match_id = request.form['match_id']
            team_id = request.form['team_id']
            score = request.form['score']
            win = request.form['win'] == 'on'
            draw = request.form['draw'] == 'on'
            cur.execute('INSERT INTO results (match_id, team_id, score, win, draw) VALUES (%s, %s, %s, %s, %s)', 
                        (match_id, team_id, score, win, draw))
            db.commit()
            cur.close()
            flash('Result added successfully', 'success')
            return redirect(url_for('admin.add_result'))
        except Exception as e:
            db.rollback()
            print("Error: ", str(e))
            flash('Failed to add result', 'error')
            return redirect(url_for('admin.add_result'))

    cur = db.cursor()
    cur.execute('SELECT match_id, team_id, score, win, draw FROM results')
    results = cur.fetchall()
    cur.close()
    return render_template('add_result.html', results=results)


@admin_bp.route('/add_score', methods=['GET', 'POST'])
@admin_required
def add_score():
    db = get_db()
    if request.method == 'POST':
        try:
            cur = db.cursor()
            match_id = request.form['match_id']
            player_id = request.form['player_id']
            score = request.form['score']
            cur.execute('INSERT INTO scores (match_id, player_id, score) VALUES (%s, %s, %s)', 
                        (match_id, player_id, score))
            db.commit()
            cur.close()
            flash('Score added successfully', 'success')
            return redirect(url_for('admin.add_score'))
        except Exception as e:
            db.rollback()
            print("Error: ", str(e))
            flash('Failed to add score', 'error')
            return redirect(url_for('admin.add_score'))

    cur = db.cursor()
    cur.execute('SELECT match_id, player_id, score FROM scores')
    scores = cur.fetchall()
    cur.close()
    return render_template('add_score.html', scores=scores)


@admin_bp.route('/add_game_stat', methods=['GET', 'POST'])
@admin_required
def add_game_stat():
    db = get_db()
    if request.method == 'POST':
        try:
            cur = db.cursor()
            match_id = request.form['match_id']
            stat_type = request.form['stat_type']
            value = request.form['value']
            cur.execute('INSERT INTO game_stats (match_id, stat_type, value) VALUES (%s, %s, %s)', 
                        (match_id, stat_type, value))
            db.commit()
            cur.close()
            flash('Game stat added successfully', 'success')
            return redirect(url_for('admin.add_game_stat'))
        except Exception as e:
            db.rollback()
            print("Error: ", str(e))
            flash('Failed to add game stat', 'error')
            return redirect(url_for('admin.add_game_stat'))

    cur = db.cursor()
    cur.execute('SELECT match_id, stat_type, value FROM game_stats')
    game_stats = cur.fetchall()
    cur.close()
    return render_template('add_game_stat.html', game_stats=game_stats)

