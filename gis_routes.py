from flask import Blueprint, jsonify, request
from db import get_db

gis_bp = Blueprint('gis', __name__)




@gis_bp.route('/api/stadiums')
def api_stadiums():
    db = get_db()
    cur = db.cursor()

    city = request.args.get('city')
    country = request.args.get('country')
    league_id = request.args.get('league_id')

    query = """
        SELECT DISTINCT
    s.stadium_id,
    s.name,
    s.location,
    s.capacity,
    s.city,
    s.country,
    s.latitude,
    s.longitude,
    t.name AS team_name,
    l.name AS league_name,
    t.team_id,
    l.color AS league_color
FROM stadiums s
LEFT JOIN teams t ON t.stadium_id = s.stadium_id
LEFT JOIN leagues l ON t.league_id = l.league_id
WHERE s.latitude IS NOT NULL
AND s.longitude IS NOT NULL
    """

    params = []

    if city:
        query += " AND LOWER(s.city) LIKE LOWER(%s)"
        params.append(f"%{city}%")

    if country:
        query += " AND LOWER(s.country) LIKE LOWER(%s)"
        params.append(f"%{country}%")

    if league_id:
        query += " AND t.league_id = %s"
        params.append(league_id)

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
    "longitude": float(stadium[7]),
    "team_name": stadium[8],
    "league_name": stadium[9],
    "league_color": stadium[11],
    "team_id": stadium[10]
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
            s.stadium_id,
            s.name,
            s.location,
            s.capacity,
            s.city,
            s.country,
            s.latitude,
            s.longitude,
            t.name AS team_name,
            l.name AS league_name,
            l.color AS league_color,
            ST_Distance(
                s.geom::geography,
                ST_SetSRID(ST_MakePoint(%s, %s), 4326)::geography
            ) / 1000 AS distance_km
        FROM stadiums s
        LEFT JOIN teams t ON t.stadium_id = s.stadium_id
        LEFT JOIN leagues l ON t.league_id = l.league_id
        WHERE s.geom IS NOT NULL
          AND ST_DWithin(
                s.geom::geography,
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

    features = []

    for stadium in stadiums:
        features.append({
            "type": "Feature",
            "geometry": {
                "type": "Point",
                "coordinates": [
                    float(stadium[7]),
                    float(stadium[6])
                ]
            },
            "properties": {
                "id": stadium[0],
                "name": stadium[1],
                "location": stadium[2],
                "capacity": stadium[3],
                "city": stadium[4],
                "country": stadium[5],
                "team_name": stadium[8],
                "league_name": stadium[9],
                "league_color": stadium[10],
                "distance_km": round(stadium[11], 2)
            }
        })

    return jsonify({
        "type": "FeatureCollection",
        "features": features
    })
@gis_bp.route('/api/stadiums/geojson')
def api_stadiums_geojson():
    db = get_db()
    cur = db.cursor()

    city = request.args.get('city')
    country = request.args.get('country')
    league_id = request.args.get('league_id')

    query = """
        SELECT DISTINCT
            s.stadium_id,
            s.name,
            s.location,
            s.capacity,
            s.city,
            s.country,
            s.latitude,
            s.longitude,
            t.name AS team_name,
            l.name AS league_name,
            t.team_id,
            l.color AS league_color
        FROM stadiums s
        LEFT JOIN teams t ON t.stadium_id = s.stadium_id
        LEFT JOIN leagues l ON t.league_id = l.league_id
        WHERE s.latitude IS NOT NULL
          AND s.longitude IS NOT NULL
    """

    params = []

    if city:
        query += " AND LOWER(s.city) LIKE LOWER(%s)"
        params.append(f"%{city}%")

    if country:
        query += " AND LOWER(s.country) LIKE LOWER(%s)"
        params.append(f"%{country}%")

    if league_id:
        query += " AND t.league_id = %s"
        params.append(league_id)

    cur.execute(query, params)
    stadiums = cur.fetchall()
    cur.close()

    features = []

    for stadium in stadiums:
        features.append({
            "type": "Feature",
            "geometry": {
                "type": "Point",
                "coordinates": [float(stadium[7]), float(stadium[6])]
            },
            "properties": {
                "id": stadium[0],
                "name": stadium[1],
                "location": stadium[2],
                "capacity": stadium[3],
                "city": stadium[4],
                "country": stadium[5],
                "team_name": stadium[8],
                "league_name": stadium[9],
                "team_id": stadium[10],
                "league_color": stadium[11]
            }
        })

    return jsonify({
        "type": "FeatureCollection",
        "features": features
    })