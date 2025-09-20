from flask import Flask, render_template, request, redirect, session, url_for, flash
from db import get_db_connection
import os
from admin_routes import admin_bp
from player_routes import player_bp
from auth_utils import hash_password, verify_password
from flask import jsonify, send_from_directory
from auth_utils import admin_required, login_required  # you already import hash/verify
from notification import WebPushClient, build_payload


app = Flask(__name__)
app.secret_key = os.getenv('SECRET_KEY', 'dev')
DATABASE_URL = os.environ.get("DATABASE_URL")

app.register_blueprint(admin_bp)
app.register_blueprint(player_bp)


@app.route('/')
def index():
    return redirect(url_for('login'))

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        password = hash_password(request.form['password'])
        role = 'player'
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("SELECT * FROM users WHERE username = %s", (username,))
        if cur.fetchone():
            flash("Username already exists.", "danger")
        else:
            cur.execute("INSERT INTO users (username, password, role) VALUES (%s, %s, %s)", (username, password, role))
            conn.commit()
            flash("Registration successful!", "success")
            return redirect(url_for('login'))
        cur.close()
        conn.close()
    return render_template('register.html')


@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("SELECT * FROM users WHERE username = %s", (username,))
        user = cur.fetchone()
        cur.close()
        conn.close()

        # ✅ Verify hashed password
        if user and verify_password(password, user[2]):  # assuming user[2] is the hashed password
            session['user_id'] = user[0]
            session['username'] = user[1]
            session['role'] = user[3]

            if user[3] == 'player':
                conn = get_db_connection()
                cur = conn.cursor()
                cur.execute("SELECT id FROM players WHERE user_id = %s", (user[0],))
                player = cur.fetchone()
                if player:
                    session['player_id'] = player[0]
                cur.close()
                conn.close()

            return redirect(url_for('player.dashboard'))
        else:
            flash('Invalid credentials', 'danger')

    return render_template('login.html')


@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('login'))

# --- PWA / Web Push helpers ---

@app.route('/admin/test')
@admin_required
def admin_test():
    # Admin-only utilities page (contains the Web Push test module)
    return render_template('test.html')

@app.route('/vapid_public_key')
@admin_required   # keep this admin-only for now since it's just for the test page
def vapid_public_key():
    # Return your Base64URL VAPID public key for PushManager.subscribe()
    key = os.getenv("VAPID_PUBLIC_KEY", "")
    return jsonify({"key": key})

@app.route('/push_test_now', methods=['POST'])
@admin_required   # test endpoint; later we’ll add proper save/broadcast flows
def push_test_now():
    sub = request.get_json(silent=True) or {}
    if not sub or "endpoint" not in sub:
        return jsonify({"ok": False, "error": "Invalid subscription"}), 400

    client = WebPushClient()
    # Build a simple payload the service worker expects
    data_json = build_payload(
        title="🎱 Pool League",
        body="This is a web push test. It worked!",
        url="/",
        icon="/static/icons/icon-192.png"
    )

    ok = client.send_to_subscription(sub, data_json, ttl=60)
    return jsonify({"ok": ok})

@app.route('/sw.js')
def service_worker():
    # Register service worker at the site root: navigator.serviceWorker.register('/sw.js')
    return send_from_directory('static', 'sw.js', mimetype='application/javascript')


if __name__ == '__main__':
    app.run(debug=True)
