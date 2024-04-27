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

@app.route('/manage_teams')
def manage_teams():
    teams = query_db('SELECT * FROM teams')  # Adjust the SQL based on your schema
    return render_template('manage_teams.html', teams=teams)

@app.route('/manage_players')
def manage_players():
    players = query_db('SELECT * FROM players')  # Adjust the SQL based on your schema
    return render_template('manage_players.html', players=players)

@app.route('/manage_games')
def manage_games():
    games = query_db('SELECT * FROM games')  # Adjust the SQL based on your schema
    return render_template('manage_games.html', games=games)


if __name__ == '__main__':
    app.run(debug=True)
