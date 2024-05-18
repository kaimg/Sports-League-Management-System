from flask import Flask, render_template, request, redirect, session, g, url_for, flash
from db import get_db, close_db
from admin_routes import admin_bp
from user_routes import user_bp

app = Flask(__name__)
app.secret_key = 'your_secret_key'  # Replace with a secure key

app.register_blueprint(admin_bp)
app.register_blueprint(user_bp)

@app.teardown_appcontext
def teardown_db(exception):
    close_db()

@app.route('/')
def landing():
    return render_template('landing.html')

@app.route('/home')
def home():
    if 'user_id' in session:
        if session.get('is_admin'):
            return redirect(url_for('admin'))
        else:
            return redirect(url_for('user'))
    else:
        return redirect(url_for('login'))

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        db = get_db()
        cur = db.cursor()
        username = request.form['username']
        password = request.form['password']
        cur.execute(
            'SELECT user_id, username, password, is_admin FROM users WHERE username = %s',
            (username, ))
        user = cur.fetchone()
        cur.close()
        if user and user[2] == password:
            session['user_id'] = user[0]
            session['username'] = user[1]
            session['is_admin'] = user[3]
            return redirect(url_for('home'))
        else:
            flash('Invalid username or password', 'error')
            return redirect(url_for('login'))

    return render_template('login.html')

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        try:
            db = get_db()
            cur = db.cursor()
            username = request.form['username']
            password = request.form['password']
            email = request.form['email']

            # Check if the username already exists
            cur.execute('SELECT * FROM users WHERE username = %s', (username,))
            existing_user = cur.fetchone()
            if existing_user:
                flash('Username already taken', 'error')
                return redirect(url_for('register'))

            # Check if the email already exists
            cur.execute('SELECT * FROM users WHERE email = %s', (email,))
            existing_email = cur.fetchone()
            if existing_email:
                flash('Email already registered', 'error')
                return redirect(url_for('register'))

            cur.execute(
                'INSERT INTO users (username, password, email, is_admin) VALUES (%s, %s, %s, %s)',
                (username, password, email, False))
            db.commit()
            cur.close()
            flash('Registration successful', 'success')
            return redirect(url_for('login'))
        except Exception as e:
            db.rollback()
            print("Error: ", str(e))
            flash('Registration failed', 'error')
            return redirect(url_for('register'))
    return render_template('register.html')

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('landing'))

@app.route('/admin')
def admin():
    if 'user_id' not in session or not session.get('is_admin'):
        return redirect(url_for('login'))
    return render_template('admin.html')

@app.route('/user')
def user():
    if 'user_id' not in session:
        return redirect(url_for('login'))
    db = get_db()
    cur = db.cursor()
    cur.execute('SELECT * FROM users;')
    users = cur.fetchall()
    cur.close()
    return render_template('user.html', users=users)

@app.route('/add_user', methods=['GET', 'POST'])
def add_user():
    if 'user_id' not in session:
        return redirect(url_for('login'))
    if request.method == 'POST':
        try:
            db = get_db()
            cur = db.cursor()
            username = request.form['username']
            password = request.form['password']
            email = request.form['email']
            cur.execute(
                'INSERT INTO users (username, password, email) VALUES (%s, %s, %s)',
                (username, password, email))
            db.commit()
            cur.close()
            flash('User added successfully', 'success')
            return redirect(url_for('user'))
        except Exception as e:
            db.rollback()
            print("Error: ", str(e))
            flash('Failed to add user', 'error')
            return redirect(url_for('add_user'))
    return render_template('add_user.html')

if __name__ == '__main__':
    app.run(debug=True)
