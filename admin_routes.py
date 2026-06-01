

from flask import Blueprint, render_template, request, redirect, session, url_for, flash
from functools import wraps
from db import get_db


admin_bp = Blueprint('admin', __name__)

def admin_required(f):
    @wraps(f)
    def wrap(*args, **kwargs):
        user_id = session.get('user_id')

        if not user_id:
            flash('You need to be logged in to access this page', 'error')
            return redirect(url_for('login'))

        db = get_db()
        cur = db.cursor()
        cur.execute(
            "SELECT is_admin FROM users WHERE user_id = %s",
            (user_id,)
        )
        user = cur.fetchone()
        cur.close()

        if not user or not user[0]:
            session['is_admin'] = False
            flash('You need to be an admin to access this page', 'error')
            return redirect(url_for('login'))

        session['is_admin'] = True
        return f(*args, **kwargs)

    return wrap

def get_existing_data(table_name):
    db = get_db()
    cur = db.cursor()
    cur.execute(f'SELECT * FROM {table_name}')
    data = cur.fetchall()
    cur.close()
    return data

def clean_value(value):
    if value is None:
        return None

    value = value.strip()

    if value == "" or value.lower() == "none":
        return None

    return value


def clean_int(value):
    value = clean_value(value)
    if value is None:
        return None
    return int(value)


def clean_float(value):
    value = clean_value(value)
    if value is None:
        return None
    return float(value)

@admin_bp.route('/manage_stadiums', methods=['GET', 'POST'])
@admin_required
def manage_stadiums():
    db = get_db()
    cur = db.cursor()

    if request.method == 'POST':
        try:
            stadium_id = request.form.get('stadium_id') or request.form.get('deleteItemId')

            if 'delete' in request.form:
                if not stadium_id:
                    flash('No stadium selected for deletion', 'error')
                else:
                    cur.execute("""
                        UPDATE teams
                        SET stadium_id = NULL
                        WHERE stadium_id = %s
                    """, (stadium_id,))

                    cur.execute("""
                        DELETE FROM stadiums
                        WHERE stadium_id = %s
                    """, (stadium_id,))

                    flash('Stadium deleted successfully', 'success')

            else:
                name = clean_value(request.form.get('name'))
                location = clean_value(request.form.get('location'))
                capacity = clean_int(request.form.get('capacity'))
                city = clean_value(request.form.get('city'))
                country = clean_value(request.form.get('country'))
                latitude = clean_float(request.form.get('latitude'))
                longitude = clean_float(request.form.get('longitude'))
                team_id = clean_value(request.form.get('team_id'))

                if not name:
                    flash('Stadium name is required', 'error')
                    return redirect(url_for('admin.manage_stadiums'))

                if not location:
                    flash('Stadium location is required', 'error')
                    return redirect(url_for('admin.manage_stadiums'))

                if 'add' in request.form:
                    cur.execute("""
                        INSERT INTO stadiums
                            (name, location, capacity, city, country, latitude, longitude, geom)
                        VALUES
                            (
                                %s, %s, %s, %s, %s, %s, %s,
                                CASE
                                    WHEN %s IS NOT NULL AND %s IS NOT NULL
                                    THEN ST_SetSRID(ST_MakePoint(%s, %s), 4326)
                                    ELSE NULL
                                END
                        )
                        RETURNING stadium_id
                     """, (
                        name,
                        location,
                        capacity,
                        city,
                        country,
                        latitude,
                        longitude,
                        longitude,
                        latitude,
                        longitude,
                        latitude
                    ))

                    result = cur.fetchone()

                    if not result:
                        flash('Could not create stadium', 'error')
                        db.rollback()
                        return redirect(url_for('admin.manage_stadiums'))

                    new_stadium_id = result[0]

                    if team_id:
                        cur.execute("""
                            UPDATE teams
                            SET stadium_id = %s
                            WHERE team_id = %s
                        """, (new_stadium_id, team_id))

                    flash('Stadium added successfully', 'success')

                elif 'edit' in request.form and stadium_id:
                    cur.execute("""
                        UPDATE stadiums
                        SET name = %s,
                            location = %s,
                            capacity = %s,
                            city = %s,
                            country = %s,
                            latitude = %s,
                            longitude = %s,
                            geom = CASE
                                WHEN %s IS NOT NULL AND %s IS NOT NULL
                                THEN ST_SetSRID(ST_MakePoint(%s, %s), 4326)
                                ELSE NULL
                            END
                        WHERE stadium_id = %s
                    """, (
                        name,
                        location,
                        capacity,
                        city,
                        country,
                        latitude,
                        longitude,
                        longitude,
                        latitude,
                        longitude,
                        latitude,
                        stadium_id
                    ))

                    cur.execute("""
                        UPDATE teams
                        SET stadium_id = NULL
                        WHERE stadium_id = %s
                    """, (stadium_id,))

                    if team_id:
                        cur.execute("""
                            UPDATE teams
                            SET stadium_id = %s
                            WHERE team_id = %s
                        """, (stadium_id, team_id))

                    flash('Stadium updated successfully', 'success')

            db.commit()

        except Exception as e:
            db.rollback()
            flash('An error occurred: ' + str(e), 'error')

        finally:
            cur.close()

        return redirect(url_for('admin.manage_stadiums'))

    cur.execute("""
        SELECT
            s.stadium_id,
            s.name,
            s.location,
            s.capacity,
            s.city,
            s.country,
            s.latitude,
            s.longitude,
            t.team_id,
            t.name AS team_name
        FROM stadiums s
        LEFT JOIN teams t ON t.stadium_id = s.stadium_id
        ORDER BY s.stadium_id
    """)
    stadiums = cur.fetchall()

    cur.execute("""
        SELECT team_id, name, stadium_id
        FROM teams
        ORDER BY name
    """)
    teams = cur.fetchall()

    cur.close()

    return render_template(
        'manage_stadiums.html',
        stadiums=stadiums,
        teams=teams
    )
    
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
                cur.execute('INSERT INTO seasons (league_id, year) VALUES (%s, %s)', (league_id, year))
                flash('Season added successfully', 'success')
            elif 'edit' in request.form and season_id:
                cur.execute('UPDATE seasons SET league_id = %s, year = %s WHERE season_id = %s', (league_id, year, season_id))
                flash('Season updated successfully', 'success')
            elif 'delete' in request.form:
                season_id = request.form['deleteItemId']
                cur.execute('DELETE FROM seasons WHERE season_id = %s', (season_id,))
                flash('Season deleted successfully', 'success')
            db.commit()
        except Exception as e:
            db.rollback()
            flash('An error occurred: ' + str(e), 'error')
        finally:
            cur.close()
        return redirect(url_for('admin.manage_seasons'))

    cur.execute('''
        SELECT s.season_id, s.league_id, s.year, l.name
        FROM seasons s
        JOIN leagues l ON s.league_id = l.league_id
    ''')
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
            stadium_id = request.form.get('stadium_id') or None
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

    cur.execute("""
    SELECT 
        t.team_id,
        t.name,
        t.founded_year,
        t.stadium_id,
        t.league_id,
        t.coach_id,
        COALESCE(s.name, 'N/A') AS stadium_name,
        l.name AS league_name,
        c.name AS coach_name,
        t.is_active
    FROM teams t
    LEFT JOIN stadiums s ON t.stadium_id = s.stadium_id
    JOIN leagues l ON t.league_id = l.league_id
    JOIN coaches c ON t.coach_id = c.coach_id
    ORDER BY t.team_id
""")
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
            nationality = request.form['nationality']
            team_id = request.form['team_id']

            if 'add' in request.form:
                cur.execute('INSERT INTO coaches (name, nationality, team_id) VALUES (%s, %s, %s)', 
                            (name, nationality, team_id))
                flash('Coach added successfully', 'success')
            elif 'submit' in request.form and coach_id:
                cur.execute('UPDATE coaches SET name = %s, nationality = %s, team_id = %s WHERE coach_id = %s', 
                            (name, nationality, team_id, coach_id))
                flash('Coach updated successfully', 'success')
            elif 'delete' in request.form:
                coach_id = request.form['deleteEntityId']
                cur.execute('DELETE FROM coaches WHERE coach_id = %s', (coach_id,))
                flash('Coach deleted successfully', 'success')
            db.commit()
        except Exception as e:
            db.rollback()
            flash('An error occurred: ' + str(e), 'error')
        finally:
            cur.close()
        return redirect(url_for('admin.manage_coaches'))

    cur.execute('''
        SELECT c.coach_id, c.name, c.team_id, c.nationality, t.name AS team_name
        FROM coaches c
        JOIN teams t ON c.team_id = t.team_id
    ''')
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
            position = request.form['position']
            date_of_birth = request.form['date_of_birth']
            nationality = request.form['nationality']

            if 'submit' in request.form:
                if player_id:
                    cur.execute('UPDATE players SET team_id = %s, name = %s, position = %s, date_of_birth = %s, nationality = %s WHERE player_id = %s', 
                                (team_id, name, position, date_of_birth, nationality, player_id))
                    flash('Player updated successfully', 'success')
                else:
                    cur.execute('INSERT INTO players (team_id, name, position, date_of_birth, nationality) VALUES (%s, %s, %s, %s, %s)', 
                                (team_id, name, position, date_of_birth, nationality))
                    flash('Player added successfully', 'success')
            elif 'delete' in request.form:
                player_id = request.form['deleteEntityId']
                cur.execute('DELETE FROM players WHERE player_id = %s', (player_id,))
                flash('Player deleted successfully', 'success')
            db.commit()
        except Exception as e:
            db.rollback()
            flash('An error occurred: ' + str(e), 'error')
        finally:
            cur.close()
        return redirect(url_for('admin.manage_players'))

    cur.execute('SELECT p.player_id, t.name AS team, p.name, p.position, p.date_of_birth, p.nationality, p.team_id FROM players p JOIN teams t ON p.team_id = t.team_id')
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
            team1_id = request.form['team1_id']
            team2_id = request.form['team2_id']
            season_id = request.form['season_id']
            league_id = request.form['league_id']

            if 'submit' in request.form:
                if match_id:
                    cur.execute('UPDATE matches SET utc_date = %s, home_team_id = %s, away_team_id = %s, season_id = %s, league_id = %s WHERE match_id = %s', 
                                (date, team1_id, team2_id, season_id, league_id, match_id))
                    flash('Match updated successfully', 'success')
                else:
                    cur.execute('INSERT INTO matches (utc_date, home_team_id, away_team_id, season_id, league_id) VALUES (%s, %s, %s, %s, %s)', 
                                (date, team1_id, team2_id, season_id, league_id))
                    flash('Match added successfully', 'success')
            elif 'delete' in request.form:
                match_id = request.form['deleteEntityId']
                cur.execute('DELETE FROM matches WHERE match_id = %s', (match_id,))
                flash('Match deleted successfully', 'success')
            db.commit()
        except Exception as e:
            db.rollback()
            flash('An error occurred: ' + str(e), 'error')
        finally:
            cur.close()
        return redirect(url_for('admin.manage_matches'))

    cur.execute('''
        SELECT m.match_id, m.utc_date, t1.name AS team1, t2.name AS team2, s.year AS season, l.name AS league,
               m.home_team_id, m.away_team_id, m.status
        FROM matches m
        JOIN teams t1 ON m.home_team_id = t1.team_id
        JOIN teams t2 ON m.away_team_id = t2.team_id
        JOIN seasons s ON m.season_id = s.season_id
        JOIN leagues l ON m.league_id = l.league_id
    ''')
    matches = cur.fetchall()
    cur.execute('SELECT team_id, name FROM teams')
    teams = cur.fetchall()
    cur.execute('SELECT season_id, year FROM seasons')
    seasons = cur.fetchall()
    cur.execute('SELECT league_id, name FROM leagues')
    leagues = cur.fetchall()
    cur.close()
    return render_template('manage_matches.html', matches=matches, teams=teams, seasons=seasons, leagues=leagues)


def normalize_flag_url(flag_value):
    if not flag_value:
        return None

    flag_value = flag_value.strip()

    if flag_value == "":
        return None

    if flag_value.startswith("http://") or flag_value.startswith("https://"):
        return flag_value

    return f"https://flagcdn.com/{flag_value.lower()}.svg"

@admin_bp.route('/manage_countries', methods=['GET', 'POST'])
@admin_required
def manage_countries():
    db = get_db()
    cur = db.cursor()

    if request.method == 'POST':
        try:
            if 'delete' in request.form:
                country_id = request.form.get('deleteEntityId')

                if not country_id:
                    flash('No country selected for deletion', 'error')
                    return redirect(url_for('admin.manage_countries'))

                cur.execute(
                    'DELETE FROM countries WHERE country_id = %s',
                    (country_id,)
                )

                db.commit()
                flash('Country deleted successfully', 'success')

            else:
                country_id = request.form.get('country_id')
                name = clean_value(request.form.get('name'))
                flag_url = normalize_flag_url(request.form.get('flag_url'))

                if not name:
                    flash('Country name is required', 'error')
                    return redirect(url_for('admin.manage_countries'))

                if country_id:
                    cur.execute(
                        """
                        SELECT country_id
                        FROM countries
                        WHERE (
                            LOWER(name) = LOWER(%s)
                            OR flag_url = %s
                        )
                        AND country_id <> %s
                        LIMIT 1
                        """,
                        (name, flag_url, country_id)
                    )

                    existing_country = cur.fetchone()

                    if existing_country:
                        flash('Another country with this name or flag already exists.', 'warning')
                        return redirect(url_for('admin.manage_countries'))

                    cur.execute(
                        """
                        UPDATE countries
                        SET name = %s,
                            flag_url = %s
                        WHERE country_id = %s
                        """,
                        (name, flag_url, country_id)
                    )

                    db.commit()
                    flash('Country updated successfully', 'success')

                else:
                    cur.execute(
                        """
                        SELECT country_id
                        FROM countries
                        WHERE LOWER(name) = LOWER(%s)
                        OR flag_url = %s
                        LIMIT 1
                        """,
                        (name, flag_url)
                    )

                    existing_country = cur.fetchone()

                    if existing_country:
                        flash('This country or flag already exists.', 'warning')
                        return redirect(url_for('admin.manage_countries'))

                    cur.execute(
                        """
                        INSERT INTO countries (name, flag_url)
                        VALUES (%s, %s)
                        """,
                        (name, flag_url)
                    )

                    db.commit()
                    flash('Country added successfully', 'success')

        except Exception as e:
            db.rollback()
            error_message = str(e).lower()

            if 'foreign key' in error_message:
                flash(
                    'This country cannot be deleted because it is being used by leagues, teams, players, referees, or other records.',
                    'warning'
                )
            elif 'duplicate key value' in error_message or 'unique constraint' in error_message:
                flash('Country already exists or the country ID sequence is out of sync.', 'warning')
            else:
                flash('An error occurred: ' + str(e), 'error')

        finally:
            cur.close()

        return redirect(url_for('admin.manage_countries'))

    cur.execute("""
        SELECT country_id, name, flag_url
        FROM countries
        ORDER BY country_id ASC
    """)
    countries = cur.fetchall()
    cur.close()

    return render_template('manage_countries.html', countries=countries)



@admin_bp.route('/manage_referees', methods=['GET', 'POST'])
@admin_required
def manage_referees():
    db = get_db()
    cur = db.cursor()

    if request.method == 'POST':
        try:
            referee_id = request.form.get('referee_id')
            name = request.form['name']
            nationality = request.form['nationality']

            if 'submit' in request.form:
                if referee_id:
                    cur.execute('UPDATE referees SET name = %s, nationality = %s WHERE referee_id = %s', 
                                (name, nationality, referee_id))
                    flash('Referee updated successfully', 'success')
                else:
                    cur.execute('INSERT INTO referees (name, nationality) VALUES (%s, %s)', 
                                (name, nationality))
                    flash('Referee added successfully', 'success')
            elif 'delete' in request.form:
                referee_id = request.form['deleteEntityId']
                cur.execute('DELETE FROM referees WHERE referee_id = %s', (referee_id,))
                flash('Referee deleted successfully', 'success')
            db.commit()
        except Exception as e:
            db.rollback()
            flash('An error occurred: ' + str(e), 'error')
        finally:
            cur.close()
        return redirect(url_for('admin.manage_referees'))

    cur.execute('SELECT referee_id, name, nationality FROM referees')
    referees = cur.fetchall()
    cur.close()
    return render_template('manage_referees.html', referees=referees)



@admin_bp.route('/manage_scorers', methods=['GET', 'POST'])
@admin_required
def manage_scorers():
    db = get_db()
    cur = db.cursor()

    if request.method == 'POST':
        try:
            scorer_id = request.form.get('scorer_id')
            player_id = request.form['player_id']
            season_id = request.form['season_id']
            league_id = request.form['league_id']
            goals = request.form['goals']
            assists = request.form['assists']
            penalties = request.form['penalties']

            if 'submit' in request.form:
                if scorer_id:
                    cur.execute('UPDATE scorers SET player_id = %s, season_id = %s, league_id = %s, goals = %s, assists = %s, penalties = %s WHERE scorer_id = %s',
                                (player_id, season_id, league_id, goals, assists, penalties, scorer_id))
                    flash('Scorer updated successfully', 'success')
                else:
                    cur.execute('INSERT INTO scorers (player_id, season_id, league_id, goals, assists, penalties) VALUES (%s, %s, %s, %s, %s, %s)',
                                (player_id, season_id, league_id, goals, assists, penalties))
                    flash('Scorer added successfully', 'success')
            elif 'delete' in request.form:
                scorer_id = request.form['deleteEntityId']
                cur.execute('DELETE FROM scorers WHERE scorer_id = %s', (scorer_id,))
                flash('Scorer deleted successfully', 'success')
            db.commit()
        except Exception as e:
            db.rollback()
            flash('An error occurred: ' + str(e), 'error')
        finally:
            cur.close()
        return redirect(url_for('admin.manage_scorers'))

    cur.execute('''
        SELECT s.scorer_id, p.name, se.year, l.name, s.goals, s.assists, s.penalties 
        FROM scorers s 
        JOIN players p ON s.player_id = p.player_id 
        JOIN seasons se ON s.season_id = se.season_id 
        JOIN leagues l ON s.league_id = l.league_id
    ''')
    scorers = cur.fetchall()
    cur.execute('SELECT player_id, name FROM players')
    players = cur.fetchall()
    cur.execute('SELECT season_id, year FROM seasons')
    seasons = cur.fetchall()
    cur.execute('SELECT league_id, name FROM leagues')
    leagues = cur.fetchall()
    cur.close()
    return render_template('manage_scorers.html', scorers=scorers, players=players, seasons=seasons, leagues=leagues)



@admin_bp.route('/manage_scores', methods=['GET', 'POST'])
@admin_required
def manage_scores():
    db = get_db()
    cur = db.cursor()

    if request.method == 'POST':
        try:
            score_id = request.form.get('score_id')
            match_id = request.form['match_id']
            full_time_home = request.form['full_time_home']
            full_time_away = request.form['full_time_away']
            half_time_home = request.form['half_time_home']
            half_time_away = request.form['half_time_away']
            new_home = int(full_time_home) if full_time_home != '' else None
            new_away = int(full_time_away) if full_time_away != '' else None

            cur.execute(
                """
                SELECT m.status, s.full_time_home, s.full_time_away,
                       m.home_team_id, m.away_team_id, m.league_id
                FROM matches m
                LEFT JOIN scores s ON m.match_id = s.match_id
                WHERE m.match_id = %s
                """,
                (match_id,),
            )
            match_row = cur.fetchone()

            if 'submit' in request.form:
                if score_id:
                    cur.execute('UPDATE scores SET match_id = %s, full_time_home = %s, full_time_away = %s, half_time_home = %s, half_time_away = %s WHERE score_id = %s',
                                (match_id, full_time_home, full_time_away, half_time_home, half_time_away, score_id))
                    flash('Score updated successfully', 'success')
                else:
                    cur.execute('INSERT INTO scores (match_id, full_time_home, full_time_away, half_time_home, half_time_away) VALUES (%s, %s, %s, %s, %s)',
                                (match_id, full_time_home, full_time_away, half_time_home, half_time_away))
                    flash('Score added successfully', 'success')

                if match_row:
                    from notification_service import process_match_notification_events

                    process_match_notification_events(
                        cur,
                        int(match_id),
                        match_row[3],
                        match_row[4],
                        match_row[5],
                        match_row[0],
                        match_row[0],
                        match_row[1],
                        match_row[2],
                        new_home,
                        new_away,
                    )
            elif 'delete' in request.form:
                score_id = request.form['deleteEntityId']
                cur.execute('DELETE FROM scores WHERE score_id = %s', (score_id,))
                flash('Score deleted successfully', 'success')
            db.commit()
        except Exception as e:
            db.rollback()
            flash('An error occurred: ' + str(e), 'error')
        finally:
            cur.close()
        return redirect(url_for('admin.manage_scores'))

    cur.execute('SELECT s.score_id, m.utc_date, s.full_time_home, s.full_time_away, s.half_time_home, s.half_time_away FROM scores s JOIN matches m ON s.match_id = m.match_id')
    scores = cur.fetchall()
    cur.execute('SELECT match_id, utc_date FROM matches')
    matches = cur.fetchall()
    cur.close()
    return render_template('manage_scores.html', scores=scores, matches=matches)



@admin_bp.route('/manage_standings', methods=['GET', 'POST'])
@admin_required
def manage_standings():
    db = get_db()
    cur = db.cursor()

    if request.method == 'POST':
        try:
            standing_id = request.form.get('standing_id')
            position = request.form['position']
            team_id = request.form['team_id']
            played_games = request.form['played_games']
            won = request.form['won']
            draw = request.form['draw']
            lost = request.form['lost']
            points = request.form['points']
            goals_for = request.form['goals_for']
            goals_against = request.form['goals_against']
            goal_difference = request.form['goal_difference']
            form = request.form['form']

            if 'add' in request.form:
                cur.execute('''
                    INSERT INTO standings (position, team_id, played_games, won, draw, lost, points, goals_for, goals_against, goal_difference, form)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                ''', (position, team_id, played_games, won, draw, lost, points, goals_for, goals_against, goal_difference, form))
                flash('Standing added successfully', 'success')
            elif 'edit' in request.form and standing_id:
                cur.execute('''
                    UPDATE standings
                    SET position = %s, team_id = %s, played_games = %s, won = %s, draw = %s, lost = %s, points = %s, goals_for = %s, goals_against = %s, goal_difference = %s, form = %s
                    WHERE standing_id = %s
                ''', (position, team_id, played_games, won, draw, lost, points, goals_for, goals_against, goal_difference, form, standing_id))
                flash('Standing updated successfully', 'success')
            elif 'delete' in request.form:
                standing_id = request.form['deleteItemId']
                cur.execute('DELETE FROM standings WHERE standing_id = %s', (standing_id,))
                flash('Standing deleted successfully', 'success')
            db.commit()
        except Exception as e:
            db.rollback()
            flash('An error occurred: ' + str(e), 'error')
        finally:
            cur.close()
        return redirect(url_for('admin.manage_standings'))

    cur.execute('''
        SELECT s.standing_id, s.position, t.name, s.played_games, s.won, s.draw, s.lost, s.points, s.goals_for, s.goals_against, s.goal_difference, s.form, s.team_id
        FROM standings s
        JOIN teams t ON s.team_id = t.team_id
    ''')
    standings = cur.fetchall()
    cur.execute('SELECT team_id, name FROM teams')
    teams = cur.fetchall()
    cur.close()
    return render_template('manage_standings.html', standings=standings, teams=teams)

@admin_bp.route('/manage_users', methods=['GET', 'POST'])
@admin_required
def manage_users():
    db = get_db()
    cur = db.cursor()

    if request.method == 'POST':
        try:
            user_id = request.form.get('user_id')
            is_admin = request.form.get('is_admin') == 'true'

            cur.execute('UPDATE users SET is_admin = %s WHERE user_id = %s', (is_admin, user_id))
            db.commit()
            flash('User privilege updated successfully', 'success')
        except Exception as e:
            db.rollback()
            flash('An error occurred: ' + str(e), 'error')
        finally:
            cur.close()
        return redirect(url_for('admin.manage_users'))

    cur.execute('SELECT user_id, username, is_admin FROM users')
    users = cur.fetchall()
    cur.close()

    return render_template('manage_users.html', users=users)

@admin_bp.route('/sync_api/matches', methods=['POST'])
@admin_required
def sync_api_matches():
    from sync_api import sync_matches_for_league
    
    leagues = ['PL', 'PD', 'SA', 'BL1', 'FL1']
    total_updated = 0
    errors = []
    
    for league in leagues:
        result = sync_matches_for_league(league)
        if "error" in result:
            # Foreign key errors might happen if a team doesn't exist yet, we catch them but log
            errors.append(f"{league}: {result['error']}")
        else:
            total_updated += int(result.get("success", 0) or 0)
            
    if errors:
        flash(f"Sync completed with some errors: {', '.join(errors)}. Updated {total_updated} matches.", "warning")
    else:
        flash(f"Successfully synced {total_updated} matches from all top 5 leagues.", "success")
        
    return redirect(url_for('admin.manage_matches'))

@admin_bp.route('/sync_api/scorers', methods=['POST'])
@admin_required
def sync_api_scorers():
    from sync_api import sync_scorers_for_league
    
    leagues = ['PL', 'PD', 'SA', 'BL1', 'FL1']
    total_updated = 0
    errors = []
    
    for league in leagues:
        result = sync_scorers_for_league(league)
        if "error" in result:
            errors.append(f"{league}: {result['error']}")
        else:
            total_updated += int(result.get("success", 0) or 0)
            
    if errors:
        flash(f"Sync completed with some errors: {', '.join(errors)}. Updated {total_updated} scorers.", "warning")
    else:
        flash(f"Successfully synced {total_updated} scorers from all top 5 leagues.", "success")
        
    return redirect(url_for('admin.manage_scorers'))

@admin_bp.route('/sync_api/teams', methods=['POST'])
@admin_required
def sync_api_teams():
    from sync_api import sync_teams_for_league
    
    leagues = ['PL', 'PD', 'SA', 'BL1', 'FL1']
    total_updated = 0
    total_players_updated = 0
    errors = []
    
    for league in leagues:
        result = sync_teams_for_league(league)
        if "error" in result:
            errors.append(f"{league}: {result['error']}")
        else:
            total_updated += int(result.get("success", 0) or 0)
            total_players_updated += int(result.get("players_success", 0) or 0)
            
    if errors:
        flash(f"Sync completed with some errors: {', '.join(errors)}. Updated {total_updated} teams and {total_players_updated} players.", "warning")
    else:
        flash(f"Successfully synced {total_updated} teams and {total_players_updated} players from all top 5 leagues.", "success")
        
    return redirect(url_for('admin.manage_teams'))

@admin_bp.route('/sync_api/all', methods=['POST'])
@admin_required
def sync_api_all():
    import threading
    from flask import current_app
    from sync_api import sync_all_data
    
    if current_app.config.get('SYNC_IN_PROGRESS'):
        flash('A background sync is already in progress. Please wait until it completes.', 'warning')
        return redirect(url_for('admin'))
        
    current_app.config['SYNC_IN_PROGRESS'] = True
    import time
    current_app.config['SYNC_START_TIME'] = time.time()
    
    # Run the orchestrator in a background thread
    app_context = current_app._get_current_object()  # type: ignore[attr-defined]
    thread = threading.Thread(target=sync_all_data, args=(app_context,))
    thread.daemon = True
    thread.start()
    
    flash("Global sync started in the background. It will take approximately 2.5 minutes. Please do not start another sync.", "info")
    return redirect(url_for('admin'))