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
def dashboard():
    return render_template('user.html')

@user_bp.route('/view_stadium', methods=['GET', 'POST'])
@login_required
def view_stadium():
    db = get_db()
    if request.method == 'POST':
        try:
            stadium_id = request.form['stadium_id']
            name = request.form['name']
            location = request.form['location']
            capacity = request.form['capacity']
            cur = db.cursor()
            cur.execute('UPDATE stadiums SET name = %s, location = %s, capacity = %s WHERE stadium_id = %s',
                        (name, location, capacity, stadium_id))
            db.commit()
            cur.close()
            flash('Stadium updated successfully', 'success')
        except Exception as e:
            db.rollback()
            print("Error: ", str(e))
            flash('Failed to update stadium', 'error')
        return redirect(url_for('user.view_stadium'))

    cur = db.cursor()
    cur.execute('SELECT * FROM stadiums')
    stadiums = cur.fetchall()
    cur.close()
    return render_template('view_stadium.html', stadiums=stadiums)

@user_bp.route('/edit_stadium/<int:stadium_id>')
@login_required
def edit_stadium(stadium_id):
    db = get_db()
    cur = db.cursor()
    cur.execute('SELECT name, location, capacity FROM stadiums WHERE stadium_id = %s', (stadium_id,))
    stadium = cur.fetchone()
    cur.close()
    return render_template('view_stadium.html', edit=True, stadium=stadium, stadium_id=stadium_id)

@user_bp.route('/view_league', methods=['GET', 'POST'])
@login_required
def view_league():
    db = get_db()
    if request.method == 'POST':
        try:
            league_id = request.form['league_id']
            name = request.form['name']
            country = request.form['country']
            cur = db.cursor()
            cur.execute('UPDATE leagues SET name = %s, country = %s WHERE league_id = %s',
                        (name, country, league_id))
            db.commit()
            cur.close()
            flash('League updated successfully', 'success')
        except Exception as e:
            db.rollback()
            print("Error: ", str(e))
            flash('Failed to update league', 'error')
        return redirect(url_for('user.view_league'))

    cur = db.cursor()
    cur.execute('SELECT * FROM leagues')
    leagues = cur.fetchall()
    cur.close()
    return render_template('view_league.html', leagues=leagues)

@user_bp.route('/edit_league/<int:league_id>')
@login_required
def edit_league(league_id):
    db = get_db()
    cur = db.cursor()
    cur.execute('SELECT name, country FROM leagues WHERE league_id = %s', (league_id,))
    league = cur.fetchone()
    cur.close()
    return render_template('view_league.html', edit=True, league=league, league_id=league_id)

@user_bp.route('/view_season', methods=['GET', 'POST'])
@login_required
def view_season():
    db = get_db()
    if request.method == 'POST':
        try:
            season_id = request.form['season_id']
            league_id = request.form['league_id']
            year = request.form['year']
            cur = db.cursor()
            cur.execute('UPDATE seasons SET league_id = %s, year = %s WHERE season_id = %s',
                        (league_id, year, season_id))
            db.commit()
            cur.close()
            flash('Season updated successfully', 'success')
        except Exception as e:
            db.rollback()
            print("Error: ", str(e))
            flash('Failed to update season', 'error')
        return redirect(url_for('user.view_season'))

    cur = db.cursor()
    cur.execute('SELECT * FROM seasons')
    seasons = cur.fetchall()
    cur.close()
    return render_template('view_season.html', seasons=seasons)

@user_bp.route('/edit_season/<int:season_id>')
@login_required
def edit_season(season_id):
    db = get_db()
    cur = db.cursor()
    cur.execute('SELECT league_id, year FROM seasons WHERE season_id = %s', (season_id,))
    season = cur.fetchone()
    cur.close()
    return render_template('view_season.html', edit=True, season=season, season_id=season_id)

@user_bp.route('/view_team', methods=['GET', 'POST'])
@login_required
def view_team():
    db = get_db()
    if request.method == 'POST':
        try:
            team_id = request.form['team_id']
            name = request.form['name']
            manager = request.form['manager']
            founded_year = request.form['founded_year']
            stadium_id = request.form['stadium_id']
            league_id = request.form['league_id']
            cur = db.cursor()
            cur.execute('UPDATE teams SET name = %s, manager = %s, founded_year = %s, stadium_id = %s, league_id = %s WHERE team_id = %s',
                        (name, manager, founded_year, stadium_id, league_id, team_id))
            db.commit()
            cur.close()
            flash('Team updated successfully', 'success')
        except Exception as e:
            db.rollback()
            print("Error: ", str(e))
            flash('Failed to update team', 'error')
        return redirect(url_for('user.view_team'))

    cur = db.cursor()
    cur.execute('SELECT * FROM teams')
    teams = cur.fetchall()
    cur.close()
    return render_template('view_team.html', teams=teams)

@user_bp.route('/edit_team/<int:team_id>')
@login_required
def edit_team(team_id):
    db = get_db()
    cur = db.cursor()
    cur.execute('SELECT name, manager, founded_year, stadium_id, league_id FROM teams WHERE team_id = %s', (team_id,))
    team = cur.fetchone()
    cur.close()
    return render_template('view_team.html', edit=True, team=team, team_id=team_id)

@user_bp.route('/view_coach', methods=['GET', 'POST'])
@login_required
def view_coach():
    db = get_db()
    if request.method == 'POST':
        try:
            coach_id = request.form['coach_id']
            name = request.form['name']
            team_id = request.form['team_id']
            cur = db.cursor()
            cur.execute('UPDATE coaches SET name = %s, team_id = %s WHERE coach_id = %s',
                        (name, team_id, coach_id))
            db.commit()
            cur.close()
            flash('Coach updated successfully', 'success')
        except Exception as e:
            db.rollback()
            print("Error: ", str(e))
            flash('Failed to update coach', 'error')
        return redirect(url_for('user.view_coach'))

    cur = db.cursor()
    cur.execute('SELECT * FROM coaches')
    coaches = cur.fetchall()
    cur.close()
    return render_template('view_coach.html', coaches=coaches)

@user_bp.route('/edit_coach/<int:coach_id>')
@login_required
def edit_coach(coach_id):
    db = get_db()
    cur = db.cursor()
    cur.execute('SELECT name, team_id FROM coaches WHERE coach_id = %s', (coach_id,))
    coach = cur.fetchone()
    cur.close()
    return render_template('view_coach.html', edit=True, coach=coach, coach_id=coach_id)

@user_bp.route('/view_player', methods=['GET', 'POST'])
@login_required
def view_player():
    db = get_db()
    if request.method == 'POST':
        try:
            player_id = request.form['player_id']
            name = request.form['name']
            age = request.form['age']
            position = request.form['position']
            team_id = request.form['team_id']
            cur = db.cursor()
            cur.execute('UPDATE players SET name = %s, age = %s, position = %s, team_id = %s WHERE player_id = %s',
                        (name, age, position, team_id, player_id))
            db.commit()
            cur.close()
            flash('Player updated successfully', 'success')
        except Exception as e:
            db.rollback()
            print("Error: ", str(e))
            flash('Failed to update player', 'error')
        return redirect(url_for('user.view_player'))

    cur = db.cursor()
    cur.execute('SELECT * FROM players')
    players = cur.fetchall()
    cur.close()
    return render_template('view_player.html', players=players)

@user_bp.route('/edit_player/<int:player_id>')
@login_required
def edit_player(player_id):
    db = get_db()
    cur = db.cursor()
    cur.execute('SELECT name, age, position, team_id FROM players WHERE player_id = %s', (player_id,))
    player = cur.fetchone()
    cur.close()
    return render_template('view_player.html', edit=True, player=player, player_id=player_id)

@user_bp.route('/view_match', methods=['GET', 'POST'])
@login_required
def view_match():
    db = get_db()
    if request.method == 'POST':
        try:
            match_id = request.form['match_id']
            date = request.form['date']
            location = request.form['location']
            team1_id = request.form['team1_id']
            team2_id = request.form['team2_id']
            season_id = request.form['season_id']
            league_id = request.form['league_id']
            cur = db.cursor()
            cur.execute('UPDATE matches SET date = %s, location = %s, team1_id = %s, team2_id = %s, season_id = %s, league_id = %s WHERE match_id = %s',
                        (date, location, team1_id, team2_id, season_id, league_id, match_id))
            db.commit()
            cur.close()
            flash('Match updated successfully', 'success')
        except Exception as e:
            db.rollback()
            print("Error: ", str(e))
            flash('Failed to update match', 'error')
        return redirect(url_for('user.view_match'))

    cur = db.cursor()
    cur.execute('SELECT * FROM matches')
    matches = cur.fetchall()
    cur.close()
    return render_template('view_match.html', matches=matches)

@user_bp.route('/edit_match/<int:match_id>')
@login_required
def edit_match(match_id):
    db = get_db()
    cur = db.cursor()
    cur.execute('SELECT date, location, team1_id, team2_id, season_id, league_id FROM matches WHERE match_id = %s', (match_id,))
    match = cur.fetchone()
    cur.close()
    return render_template('view_match.html', edit=True, match=match, match_id=match_id)

@user_bp.route('/view_result', methods=['GET', 'POST'])
@login_required
def view_result():
    db = get_db()
    if request.method == 'POST':
        try:
            match_id = request.form['match_id']
            team_id = request.form['team_id']
            score = request.form['score']
            win = request.form['win'] == 'on'
            draw = request.form['draw'] == 'on'
            cur = db.cursor()
            cur.execute('UPDATE results SET score = %s, win = %s, draw = %s WHERE match_id = %s AND team_id = %s',
                        (score, win, draw, match_id, team_id))
            db.commit()
            cur.close()
            flash('Result updated successfully', 'success')
        except Exception as e:
            db.rollback()
            print("Error: ", str(e))
            flash('Failed to update result', 'error')
        return redirect(url_for('user.view_result'))

    cur = db.cursor()
    cur.execute('SELECT * FROM results')
    results = cur.fetchall()
    cur.close()
    return render_template('view_result.html', results=results)

@user_bp.route('/edit_result/<int:match_id>/<int:team_id>')
@login_required
def edit_result(match_id, team_id):
    db = get_db()
    cur = db.cursor()
    cur.execute('SELECT score, win, draw FROM results WHERE match_id = %s AND team_id = %s', (match_id, team_id))
    result = cur.fetchone()
    cur.close()
    return render_template('view_result.html', edit=True, result=result, match_id=match_id, team_id=team_id)

@user_bp.route('/view_score', methods=['GET', 'POST'])
@login_required
def view_score():
    db = get_db()
    if request.method == 'POST':
        try:
            match_id = request.form['match_id']
            player_id = request.form['player_id']
            score = request.form['score']
            cur = db.cursor()
            cur.execute('UPDATE scores SET score = %s WHERE match_id = %s AND player_id = %s',
                        (score, match_id, player_id))
            db.commit()
            cur.close()
            flash('Score updated successfully', 'success')
        except Exception as e:
            db.rollback()
            print("Error: ", str(e))
            flash('Failed to update score', 'error')
        return redirect(url_for('user.view_score'))

    cur = db.cursor()
    cur.execute('SELECT * FROM scores')
    scores = cur.fetchall()
    cur.close()
    return render_template('view_score.html', scores=scores)

@user_bp.route('/edit_score/<int:match_id>/<int:player_id>')
@login_required
def edit_score(match_id, player_id):
    db = get_db()
    cur = db.cursor()
    cur.execute('SELECT score FROM scores WHERE match_id = %s AND player_id = %s', (match_id, player_id))
    score = cur.fetchone()
    cur.close()
    return render_template('view_score.html', edit=True, score=score, match_id=match_id, player_id=player_id)

@user_bp.route('/view_game_stat', methods=['GET', 'POST'])
@login_required
def view_game_stat():
    db = get_db()
    if request.method == 'POST':
        try:
            match_id = request.form['match_id']
            stat_type = request.form['stat_type']
            value = request.form['value']
            cur = db.cursor()
            cur.execute('UPDATE game_stats SET value = %s WHERE match_id = %s AND stat_type = %s',
                        (value, match_id, stat_type))
            db.commit()
            cur.close()
            flash('Game stat updated successfully', 'success')
        except Exception as e:
            db.rollback()
            print("Error: ", str(e))
            flash('Failed to update game stat', 'error')
        return redirect(url_for('user.view_game_stat'))

    cur = db.cursor()
    cur.execute('SELECT * FROM game_stats')
    game_stats = cur.fetchall()
    cur.close()
    return render_template('view_game_stat.html', game_stats=game_stats)

@user_bp.route('/edit_game_stat/<int:match_id>/<string:stat_type>')
@login_required
def edit_game_stat(match_id, stat_type):
    db = get_db()
    cur = db.cursor()
    cur.execute('SELECT value FROM game_stats WHERE match_id = %s AND stat_type = %s', (match_id, stat_type))
    game_stat = cur.fetchone()
    cur.close()
    return render_template('view_game_stat.html', edit=True, game_stat=game_stat, match_id=match_id, stat_type=stat_type)
