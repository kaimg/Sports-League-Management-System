from db import get_db
from main import app

with app.app_context():
    cur = get_db().cursor()
    cur.execute("SELECT team_id, name, is_active FROM teams WHERE name ILIKE '%barcelona%'")
    teams = cur.fetchall()
    print('Barcelona teams:', teams)
