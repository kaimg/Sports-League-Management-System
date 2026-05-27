from db import get_db
from main import app
with app.app_context():
    cur = get_db().cursor()
    cur.execute("SELECT coach_id FROM teams WHERE team_id = 81")
    team = cur.fetchone()
    print('Coach ID for Barcelona:', team)
    if team and team[0]:
        cur.execute("SELECT name, nationality FROM coaches WHERE coach_id = %s", (team[0],))
        print('Coach details:', cur.fetchone())
