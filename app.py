from flask import Flask, render_template, request, redirect, url_for, session
from db import query_db
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)
app.config['SECRET_KEY'] = 'your_secret_key_here'
app.config['DATABASE_URL'] = 'DATABASE_URL=postgresql://postgres:admin@localhost:5432/postgres'

@app.route('/')
def home():
    # If a user is logged in, use the home.html to display a welcome message
    if 'username' in session:
        return render_template('home.html', username=session['username'])
    # If no user is logged in, display the generic welcome message
    return render_template('home.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        user = query_db('SELECT * FROM users WHERE username = %s', (username,), one=True)
        if user and check_password_hash(user['password'], password):
            session['username'] = user['username']
            return redirect(url_for('home'))
        return 'Invalid username or password'  # Consider updating this to show the error within the login.html template
    return render_template('login.html')

@app.route('/logout')
def logout():
    session.pop('username', None)
    return redirect(url_for('home'))

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        hashed_password = generate_password_hash(password)
        query_db('INSERT INTO users (username, password) VALUES (%s, %s)', (username, hashed_password), commit=True)
        return redirect(url_for('login'))
    return render_template('register.html')

from flask import Flask, render_template, request, redirect, url_for

@app.route('/manage_teams', methods=['GET', 'POST'])
def manage_teams():
    if request.method == 'POST':
        team_name = request.form['team_name']
        # Assume the function 'query_db' is your way to interact with the database
        query_db('INSERT INTO teams (name) VALUES (%s)', [team_name], commit=True)
        return redirect(url_for('manage_teams'))  # Redirect to clear the form / prevent re-submission

    teams = query_db('SELECT * FROM teams', one=False)  # Fetch all teams to display
    return render_template('manage_teams.html', teams=teams)

@app.route('/manage_players', methods=['GET', 'POST'])
def manage_players():
    if request.method == 'POST':
        player_name = request.form['player_name']
        team_id = request.form['team_id']
        position = request.form['position']
        query_db('INSERT INTO players (team_id, name, position) VALUES (%s, %s, %s)',
                 [team_id, player_name, position], commit=True)
        return redirect(url_for('manage_players'))

    players = query_db('SELECT * FROM players', one=False)
    return render_template('manage_players.html', players=players)


@app.route('/manage_games', methods=['GET', 'POST'])
def manage_games():
    if request.method == 'POST':
        team1_id = request.form['team1_id']
        team2_id = request.form['team2_id']
        date = request.form['date']
        query_db('INSERT INTO games (team1_id, team2_id, date) VALUES (%s, %s, %s)',
                 [team1_id, team2_id, date], commit=True)
        return redirect(url_for('manage_games'))
    pass
    # Adjust the SQL query to join with the teams table and get team names
    games = query_db('''SELECT games.game_id, games.date,
                               team1.name as team1_name, team2.name as team2_name
                        FROM games
                        JOIN teams as team1 ON games.team1_id = team1.team_id
                        JOIN teams as team2 ON games.team2_id = team2.team_id
                        ORDER BY games.date ASC''', one=False)
    return render_template('manage_games.html', games=games)

@app.route('/delete_game/<int:game_id>', methods=['POST'])
def delete_game(game_id):
    query_db('DELETE FROM games WHERE game_id = %s', [game_id], commit=True)
    return redirect(url_for('manage_games'))

if __name__ == '__main__':
    app.run(debug=True)
