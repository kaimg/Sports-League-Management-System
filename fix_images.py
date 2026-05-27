import psycopg2
from config import Config

def get_connection():
    """Conecta a la base de datos usando las credenciales del proyecto."""
    try:
        conn = psycopg2.connect(Config.DATABASE_URL)
        return conn
    except Exception as e:
        print(f"Error conectando a la base de datos: {e}")
        return None

def check_empty_images():
    """Busca registros que no tengan imagen o tengan URLs vacías."""
    conn = get_connection()
    if not conn:
        return
    
    try:
        cursor = conn.cursor()
        
        # Equipos sin escudo
        cursor.execute("SELECT team_id, name FROM teams WHERE cresturl IS NULL OR cresturl = '';")
        teams = cursor.fetchall()
        print(f"--- Equipos sin escudo ({len(teams)}) ---")
        for t in teams[:10]:
            print(f"ID: {t[0]} - Nombre: {t[1]}")
        if len(teams) > 10:
            print(f"... y {len(teams) - 10} más.")
            
        # Ligas sin logo
        cursor.execute("SELECT league_id, name FROM leagues WHERE icon_url IS NULL OR icon_url = '';")
        leagues = cursor.fetchall()
        print(f"\n--- Ligas sin logo ({len(leagues)}) ---")
        for l in leagues:
            print(f"ID: {l[0]} - Nombre: {l[1]}")
            
        # Países sin bandera
        cursor.execute("SELECT country_id, name FROM countries WHERE flag_url IS NULL OR flag_url = '';")
        countries = cursor.fetchall()
        print(f"\n--- Países sin bandera ({len(countries)}) ---")
        for c in countries[:10]:
            print(f"ID: {c[0]} - Nombre: {c[1]}")
            
    except Exception as e:
        print(f"Error realizando consultas: {e}")
    finally:
        conn.close()

def update_team_crest(team_id, new_url):
    """Actualiza el escudo de un equipo específico."""
    conn = get_connection()
    if not conn:
        return
        
    try:
        cursor = conn.cursor()
        cursor.execute(
            "UPDATE teams SET cresturl = %s WHERE team_id = %s RETURNING name;",
            (new_url, team_id)
        )
        updated_row = cursor.fetchone()
        
        if updated_row:
            print(f"Éxito: Escudo actualizado para el equipo '{updated_row[0]}'")
            conn.commit()
        else:
            print(f"Error: No se encontró ningún equipo con el ID {team_id}")
            
    except Exception as e:
        print(f"Error actualizando equipo: {e}")
        conn.rollback()
    finally:
        conn.close()

if __name__ == "__main__":
    print("Iniciando revisión de imágenes en la Base de Datos...\n")
    
    # 1. Revisar cuántas imágenes faltan
    check_empty_images()
    
    # 2. Ejemplo de cómo actualizar un equipo (DESCOMENTAR PARA USAR)
    # team_id_a_arreglar = 123 
    # nueva_url = 'https://ejemplo.com/nuevo_escudo.png'
    # update_team_crest(team_id_a_arreglar, nueva_url)
    
    print("\nPara actualizar un equipo, edita el archivo fix_images.py y descomenta la sección de ejemplo al final.")
