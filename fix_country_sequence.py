import psycopg2
from config import Config


def fix_country_sequence():
    conn = None
    cur = None

    try:
        conn = psycopg2.connect(Config.DATABASE_URL)
        cur = conn.cursor()

        cur.execute("""
            SELECT setval(
                pg_get_serial_sequence('countries', 'country_id'),
                COALESCE((SELECT MAX(country_id) FROM countries), 1),
                true
            );
        """)

        conn.commit()
        print("Countries sequence fixed successfully.")

    except Exception as e:
        print(f"Error fixing countries sequence: {e}")

    finally:
        if cur:
            cur.close()
        if conn:
            conn.close()


if __name__ == "__main__":
    fix_country_sequence()