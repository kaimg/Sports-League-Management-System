import psycopg2
from config import Config


def fix_league_color():
    conn = None
    cur = None

    try:
        conn = psycopg2.connect(Config.DATABASE_URL)
        cur = conn.cursor()

        cur.execute("""
            ALTER TABLE leagues
            ADD COLUMN IF NOT EXISTS color VARCHAR(20) DEFAULT '#343a40';
        """)

        cur.execute("""
            UPDATE leagues SET color = '#007bff'
            WHERE LOWER(name) LIKE '%premier%';
        """)

        cur.execute("""
            UPDATE leagues SET color = '#dc3545'
            WHERE LOWER(name) LIKE '%liga%';
        """)

        cur.execute("""
            UPDATE leagues SET color = '#ffc107'
            WHERE LOWER(name) LIKE '%bundesliga%';
        """)

        cur.execute("""
            UPDATE leagues SET color = '#28a745'
            WHERE LOWER(name) LIKE '%serie%';
        """)

        cur.execute("""
            UPDATE leagues SET color = '#6f42c1'
            WHERE LOWER(name) LIKE '%ligue%';
        """)

        conn.commit()
        print("League color column added and default colors assigned successfully.")

    except Exception as e:
        print(f"Error fixing league colors: {e}")

    finally:
        if cur:
            cur.close()
        if conn:
            conn.close()


if __name__ == "__main__":
    fix_league_color()