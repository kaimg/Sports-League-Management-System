from flask import Flask, render_template, request, redirect, url_for, session
from db import query_db
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)
app.config['SECRET_KEY'] = 'your_secret_key_here'

@app.route('/')
def home():
    if 'username' in session:
        return f"Welcome {session['username']}!"
    return "Welcome to the Sports League Management System!"

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        user = query_db('SELECT * FROM users WHERE username = %s', (username,), one=True)
        if user and check_password_hash(user['password'], password):
            session['username'] = user['username']
            return redirect(url_for('home'))
        return 'Invalid username or password'
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
@app.route('/manage_teams', methods=['GET', 'POST'])
def manage_teams():
    if request.method == 'POST':
        team_name = request.form['team_name']
        query_db('INSERT INTO teams (name) VALUES (%s)', (team_name,), commit=True)
    teams = query_db('SELECT * FROM teams')
    return render_template('manage_teams.html', teams=teams)

@app.route('/add_team', methods=['POST'])
def add_team():
    team_name = request.form['team_name']
    query_db('INSERT INTO teams (name) VALUES (%s)', (team_name,), commit=True)
    return redirect(url_for('manage_teams'))

if __name__ == '__main__':
    app.run(debug=True)
