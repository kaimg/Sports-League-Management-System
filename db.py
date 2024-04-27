import psycopg2
from psycopg2.extras import RealDictCursor

def get_db_connection():
    conn = psycopg2.connect(
        host='localhost',
        dbname='sports_league',
        user='your_username',
        password='your_password'
    )
    return conn

def query_db(query, args=(), one=False, commit=False):
    conn = get_db_connection()
    cursor = conn.cursor(cursor_factory=RealDictCursor)
    cursor.execute(query, args)
    if commit:
        conn.commit()
        result = None
    else:
        result = cursor.fetchone() if one else cursor.fetchall()
    cursor.close()
    conn.close()
    return result
