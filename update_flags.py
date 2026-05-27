import psycopg2
from config import Config

# Diccionario de nombres de países a códigos de FlagCDN
COUNTRY_CODES = {
    'England': 'gb-eng',
    'Italy': 'it',
    'Spain': 'es',
    'Germany': 'de',
    'France': 'fr',
    'Albania': 'al',
    'Algeria': 'dz',
    'Andorra': 'ad',
    'Angola': 'ao',
    'Argentina': 'ar',
    'Armenia': 'am',
    'Australia': 'au',
    'Austria': 'at',
    'Belgium': 'be',
    'Benin': 'bj',
    'Bosnia-Herzegovina': 'ba',
    'Brazil': 'br',
    'Bulgaria': 'bg',
    'Burkina Faso': 'bf',
    'Cameroon': 'cm',
    'Canada': 'ca',
    'Cape Verde Islands': 'cv',
    'Chile': 'cl',
    'Colombia': 'co',
    'Congo': 'cg',
    'Costa Rica': 'cr',
    'Croatia': 'hr',
    'Cyprus': 'cy',
    'Czech Republic': 'cz',
    'DR Congo': 'cd',
    'Denmark': 'dk',
    'Dominican Republic': 'do',
    'Ecuador': 'ec',
    'Egypt': 'eg',
    'Equatorial Guinea': 'gq',
    'Estonia': 'ee',
    'Finland': 'fi',
    'Gabon': 'ga',
    'Gambia': 'gm',
    'Georgia': 'ge',
    'Ghana': 'gh',
    'Greece': 'gr',
    'Grenada': 'gd',
    'Guadeloupe': 'gp',
    'Guinea': 'gn',
    'Honduras': 'hn',
    'Hungary': 'hu',
    'Iceland': 'is',
    'Iran': 'ir',
    'Ireland': 'ie',
    'Israel': 'il',
    'Ivory Coast': 'ci',
    'Jamaica': 'jm',
    'Japan': 'jp',
    'Kosovo': 'xk',
    'Lithuania': 'lt',
    'Luxembourg': 'lu',
    'Mali': 'ml',
    'Martinique': 'mq',
    'Mexico': 'mx',
    'Montenegro': 'me',
    'Morocco': 'ma',
    'Mozambique': 'mz',
    'Netherlands': 'nl',
    'New Zealand': 'nz',
    'Nigeria': 'ng',
    'North Macedonia': 'mk',
    'Norway': 'no',
    'Paraguay': 'py',
    'Peru': 'pe',
    'Philippines': 'ph',
    'Poland': 'pl',
    'Portugal': 'pt',
    'Romania': 'ro',
    'Russia': 'ru',
    'Scotland': 'gb-sct',
    'Senegal': 'sn',
    'Serbia': 'rs',
    'Slovakia': 'sk',
    'Slovenia': 'si',
    'South Africa': 'za',
    'South Korea': 'kr',
    'Suriname': 'sr',
    'Sweden': 'se',
    'Switzerland': 'ch',
    'Syria': 'sy',
    'Togo': 'tg',
    'Tunisia': 'tn',
    'Turkey': 'tr',
    'USA': 'us',
    'Ukraine': 'ua',
    'Uruguay': 'uy',
    'Uzbekistan': 'uz',
    'Venezuela': 've',
    'Wales': 'gb-wls',
    'Zambia': 'zm',
    'Zimbabwe': 'zw',
    'Northern Ireland': 'gb-nir'
}

def update_flags():
    print("Iniciando actualización de banderas con FlagCDN...")
    try:
        conn = psycopg2.connect(Config.DATABASE_URL)
        cursor = conn.cursor()
        
        cursor.execute("SELECT country_id, name FROM countries")
        countries = cursor.fetchall()
        
        updated = 0
        not_found = []
        
        for c_id, name in countries:
            code = COUNTRY_CODES.get(name)
            if code:
                # URL de FlagCDN en formato SVG (alta calidad)
                new_url = f"https://flagcdn.com/{code}.svg"
                cursor.execute(
                    "UPDATE countries SET flag_url = %s WHERE country_id = %s",
                    (new_url, c_id)
                )
                updated += 1
            else:
                not_found.append(name)
                
        conn.commit()
        print(f"¡Éxito! Se actualizaron {updated} banderas correctamente.")
        
        if not_found:
            print(f"Advertencia: No se encontró código para {len(not_found)} países:")
            print(", ".join(not_found))
            
    except Exception as e:
        print(f"Error al actualizar la base de datos: {e}")
    finally:
        if 'conn' in locals() and conn:
            conn.close()

if __name__ == "__main__":
    update_flags()
