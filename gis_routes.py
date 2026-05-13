from flask import Blueprint, render_template, jsonify, request
from db import get_db

gis_bp = Blueprint('gis', __name__)

@gis_bp.route('/stadiums_map')
def stadiums_map():
    return render_template('stadiums_map.html')


@gis_bp.route('/api/stadiums')
def api_stadiums():
    db = get_db()
    cur = db.cursor()

    city = request.args.get('city')
    country = request.args.get('country')

    query = """
        SELECT stadium_id, name, location, capacity, city, country, latitude, longitude
        FROM stadiums
        WHERE latitude IS NOT NULL
          AND longitude IS NOT NULL
    """

    params = []

    if city:
        query += " AND LOWER(city) LIKE LOWER(%s)"
        params.append(f"%{city}%")

    if country:
        query += " AND LOWER(country) LIKE LOWER(%s)"
        params.append(f"%{country}%")

    cur.execute(query, params)

    stadiums = cur.fetchall()
    cur.close()

    data = []

    for stadium in stadiums:
        data.append({
            "id": stadium[0],
            "name": stadium[1],
            "location": stadium[2],
            "capacity": stadium[3],
            "city": stadium[4],
            "country": stadium[5],
            "latitude": float(stadium[6]),
            "longitude": float(stadium[7])
        })

    return jsonify(data)

@gis_bp.route('/api/stadiums/nearby')
def api_nearby_stadiums():
    db = get_db()
    cur = db.cursor()

    latitude = request.args.get('lat')
    longitude = request.args.get('lon')
    radius_km = request.args.get('radius', 50)

    if not latitude or not longitude:
        return jsonify({"error": "Latitude and longitude are required"}), 400

    radius_meters = float(radius_km) * 1000

    cur.execute("""
        SELECT
            stadium_id,
            name,
            location,
            capacity,
            city,
            country,
            latitude,
            longitude,
            ST_Distance(
                geom::geography,
                ST_SetSRID(ST_MakePoint(%s, %s), 4326)::geography
            ) / 1000 AS distance_km
        FROM stadiums
        WHERE geom IS NOT NULL
          AND ST_DWithin(
                geom::geography,
                ST_SetSRID(ST_MakePoint(%s, %s), 4326)::geography,
                %s
          )
        ORDER BY distance_km ASC
    """, (
        longitude,
        latitude,
        longitude,
        latitude,
        radius_meters
    ))

    stadiums = cur.fetchall()
    cur.close()

    data = []

    for stadium in stadiums:
        data.append({
            "id": stadium[0],
            "name": stadium[1],
            "location": stadium[2],
            "capacity": stadium[3],
            "city": stadium[4],
            "country": stadium[5],
            "latitude": float(stadium[6]),
            "longitude": float(stadium[7]),
            "distance_km": round(stadium[8], 2)
        })

    return jsonify(data)