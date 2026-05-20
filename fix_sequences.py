from db import get_db
from main import app

with app.app_context():
    db = get_db()
    cur = db.cursor()
    
    tables_and_seqs = [
        ('standings', 'standings_standing_id_seq', 'standing_id'),
        ('scorers', 'scorers_scorer_id_seq', 'scorer_id'),
        ('seasons', 'seasons_season_id_seq', 'season_id'),
        ('teams', 'teams_team_id_seq', 'team_id'),
        ('players', 'players_player_id_seq', 'player_id'),
        ('matches', 'matches_match_id_seq', 'match_id'),
        ('scores', 'scores_score_id_seq', 'score_id'),
    ]
    
    for table, seq, pk in tables_and_seqs:
        query = f"SELECT setval('{seq}', COALESCE((SELECT MAX({pk}) FROM {table}), 1))"
        try:
            cur.execute(query)
            print(f"Updated {seq}")
        except Exception as e:
            print(f"Error updating {seq}: {e}")
            db.rollback()
            cur = db.cursor()
            
    db.commit()
    print("All sequences updated successfully.")
