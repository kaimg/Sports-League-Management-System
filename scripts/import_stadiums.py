"""
Import stadium data from estadios_5_ligas_europeas_2025_26.csv into PostgreSQL.

Updates existing stadium rows linked to teams (name, location, capacity, city,
country, latitude, longitude). geom is filled automatically by stadium_geom_trigger.

Usage (from project root):
    python scripts/import_stadiums.py
    python scripts/import_stadiums.py --dry-run
    python scripts/import_stadiums.py --csv path/to/file.csv
"""

from __future__ import annotations

import argparse
import csv
import os
import sys
from pathlib import Path

import psycopg2
from dotenv import load_dotenv

PROJECT_ROOT = Path(__file__).resolve().parent.parent
DEFAULT_CSV = PROJECT_ROOT / "estadios_5_ligas_europeas_2025_26.csv"

# CSV team_name -> exact name in teams table (football-data.org naming)
TEAM_NAME_MAP: dict[str, str] = {
    # Premier League
    "Arsenal": "Arsenal",
    "Aston Villa": "Aston Villa",
    "Bournemouth": "AFC Bournemouth",
    "Brentford": "Brentford",
    "Brighton & Hove Albion": "Brighton & Hove Albion",
    "Burnley": "Burnley",
    "Chelsea": "Chelsea",
    "Crystal Palace": "Crystal Palace",
    "Everton": "Everton",
    "Fulham": "Fulham",
    "Liverpool": "Liverpool",
    "Manchester City": "Manchester City",
    "Manchester United": "Manchester United",
    "Newcastle United": "Newcastle United",
    "Nottingham Forest": "Nottingham Forest",
    "Tottenham Hotspur": "Tottenham Hotspur",
    "West Ham United": "West Ham United",
    "Wolverhampton Wanderers": "Wolverhampton Wanderers",
    # La Liga
    "Alavés": "Deportivo Alavés",
    "Athletic Bilbao": "Athletic Club",
    "Atlético Madrid": "Club Atlético de Madrid",
    "Barcelona": "FC Barcelona",
    "Celta Vigo": "RC Celta de Vigo",
    "Getafe": "Getafe CF",
    "Girona": "Girona FC",
    "Mallorca": "RCD Mallorca",
    "Osasuna": "CA Osasuna",
    "Rayo Vallecano": "Rayo Vallecano de Madrid",
    "Real Betis": "Real Betis Balompié",
    "Real Madrid": "Real Madrid CF",
    "Real Sociedad": "Real Sociedad de Fútbol",
    "Sevilla": "Sevilla FC",
    "Valencia": "Valencia CF",
    "Villarreal": "Villarreal CF",
    # Bundesliga
    "FC Augsburg": "FC Augsburg",
    "Union Berlin": "1. FC Union Berlin",
    "Werder Bremen": "SV Werder Bremen",
    "Borussia Dortmund": "Borussia Dortmund",
    "Eintracht Frankfurt": "Eintracht Frankfurt",
    "SC Freiburg": "SC Freiburg",
    "1. FC Heidenheim": "1. FC Heidenheim 1846",
    "TSG Hoffenheim": "TSG 1899 Hoffenheim",
    "1. FC Köln": "1. FC Köln",
    "RB Leipzig": "RB Leipzig",
    "Bayer Leverkusen": "Bayer 04 Leverkusen",
    "Mainz 05": "1. FSV Mainz 05",
    "Borussia Mönchengladbach": "Borussia Mönchengladbach",
    "Bayern Munich": "FC Bayern München",
    "VfB Stuttgart": "VfB Stuttgart",
    "VfL Wolfsburg": "VfL Wolfsburg",
    # Serie A
    "Atalanta": "Atalanta BC",
    "Bologna": "Bologna FC 1909",
    "Cagliari": "Cagliari Calcio",
    "Fiorentina": "ACF Fiorentina",
    "Genoa": "Genoa CFC",
    "Hellas Verona": "Hellas Verona FC",
    "AC Milan": "AC Milan",
    "Inter Milan": "FC Internazionale Milano",
    "Juventus": "Juventus FC",
    "Lazio": "SS Lazio",
    "Roma": "AS Roma",
    "Lecce": "US Lecce",
    "Napoli": "SSC Napoli",
    "Sassuolo": "US Sassuolo Calcio",
    "Torino": "Torino FC",
    "Udinese": "Udinese Calcio",
    # Ligue 1
    "Brest": "Stade Brestois 29",
    "Le Havre": "Le Havre AC",
    "Lens": "Racing Club de Lens",
    "Lille": "Lille OSC",
    "Lorient": "FC Lorient",
    "Lyon": "Olympique Lyonnais",
    "Marseille": "Olympique de Marseille",
    "Metz": "FC Metz",
    "Monaco": "AS Monaco FC",
    "Nantes": "FC Nantes",
    "Nice": "OGC Nice",
    "Paris Saint-Germain": "Paris Saint-Germain FC",
    "Rennes": "Stade Rennais FC 1901",
    "Strasbourg": "RC Strasbourg Alsace",
    "Toulouse": "Toulouse FC",
}

UPDATE_STADIUM_SQL = """
UPDATE stadiums
SET name = %s,
    location = %s,
    capacity = %s,
    city = %s,
    country = %s,
    latitude = %s,
    longitude = %s
WHERE stadium_id = %s
"""

INSERT_STADIUM_SQL = """
INSERT INTO stadiums (name, location, capacity, city, country, latitude, longitude)
VALUES (%s, %s, %s, %s, %s, %s, %s)
RETURNING stadium_id
"""


def load_rows(csv_path: Path) -> list[dict[str, str]]:
    with csv_path.open(encoding="utf-8-sig", newline="") as f:
        return list(csv.DictReader(f))


def find_team(cur, csv_team_name: str) -> tuple[int, str, int | None] | None:
    db_name = TEAM_NAME_MAP.get(csv_team_name, csv_team_name)
    cur.execute(
        "SELECT team_id, name, stadium_id FROM teams WHERE name = %s",
        (db_name,),
    )
    row = cur.fetchone()
    if row:
        return row[0], row[1], row[2]
    cur.execute(
        "SELECT team_id, name, stadium_id FROM teams WHERE name ILIKE %s LIMIT 1",
        (f"%{csv_team_name}%",),
    )
    row = cur.fetchone()
    if row:
        return row[0], row[1], row[2]
    return None


def stadium_key(row: dict[str, str]) -> str:
    return f"{row['stadium_name']}|{row['latitude']}|{row['longitude']}"


def parse_int(value: str) -> int | None:
    value = (value or "").strip()
    if not value:
        return None
    return int(value)


def parse_float(value: str) -> float | None:
    value = (value or "").strip()
    if not value:
        return None
    return float(value)


def import_stadiums(csv_path: Path, dry_run: bool = False) -> int:
    load_dotenv(PROJECT_ROOT / ".env")
    database_url = os.getenv("DATABASE_URL")
    if not database_url:
        print("ERROR: DATABASE_URL not set in .env", file=sys.stderr)
        return 1

    rows = load_rows(csv_path)
    conn = psycopg2.connect(database_url)
    cur = conn.cursor()

    if not dry_run:
        cur.execute(
            "SELECT setval('stadiums_stadium_id_seq', "
            "COALESCE((SELECT MAX(stadium_id) FROM stadiums), 1))"
        )

    updated_stadium_ids: set[int] = set()
    stadium_id_by_key: dict[str, int] = {}
    matched = 0
    skipped_no_team: list[str] = []
    inserted = 0

    try:
        for row in rows:
            csv_team = row["team_name"].strip()
            team = find_team(cur, csv_team)
            if not team:
                skipped_no_team.append(csv_team)
                continue

            team_id, db_team_name, stadium_id = team
            key = stadium_key(row)
            capacity = parse_int(row["capacity"])
            latitude = parse_float(row["latitude"])
            longitude = parse_float(row["longitude"])
            values = (
                row["stadium_name"].strip(),
                row["location"].strip(),
                capacity,
                row["city"].strip(),
                row["country"].strip(),
                latitude,
                longitude,
            )

            if stadium_id and stadium_id in updated_stadium_ids:
                matched += 1
                print(f"  [shared] {csv_team} -> stadium_id {stadium_id} (already updated)")
                continue

            if stadium_id:
                target_id = stadium_id
            elif key in stadium_id_by_key:
                target_id = stadium_id_by_key[key]
            else:
                target_id = None

            if target_id:
                if dry_run:
                    print(f"  [update] {csv_team} ({db_team_name}) stadium_id={target_id}")
                else:
                    cur.execute(UPDATE_STADIUM_SQL, (*values, target_id))
                updated_stadium_ids.add(target_id)
                stadium_id_by_key[key] = target_id
                matched += 1
                continue

            if dry_run:
                print(f"  [insert] {csv_team} ({db_team_name}) — new stadium")
                matched += 1
                continue

            cur.execute(INSERT_STADIUM_SQL, values)
            new_id = cur.fetchone()[0]
            cur.execute(
                "UPDATE teams SET stadium_id = %s WHERE team_id = %s",
                (new_id, team_id),
            )
            updated_stadium_ids.add(new_id)
            stadium_id_by_key[key] = new_id
            inserted += 1
            matched += 1
            print(f"  [insert] {csv_team} -> stadium_id {new_id}")

        if dry_run:
            conn.rollback()
            print("\nDry run — no changes committed.")
        else:
            conn.commit()
            print("\nChanges committed.")

        print(f"\nCSV rows: {len(rows)}")
        print(f"Matched/updated: {matched}")
        print(f"New stadiums inserted: {inserted}")
        if skipped_no_team:
            print(f"No team in DB ({len(skipped_no_team)}):")
            for name in skipped_no_team:
                print(f"  - {name}")

        return 0
    except Exception as exc:
        conn.rollback()
        print(f"ERROR: {exc}", file=sys.stderr)
        return 1
    finally:
        cur.close()
        conn.close()


def main() -> None:
    parser = argparse.ArgumentParser(description="Import stadiums from CSV")
    parser.add_argument(
        "--csv",
        type=Path,
        default=DEFAULT_CSV,
        help=f"Path to CSV (default: {DEFAULT_CSV.name})",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Show what would change without writing to the database",
    )
    args = parser.parse_args()
    if not args.csv.is_file():
        print(f"ERROR: CSV not found: {args.csv}", file=sys.stderr)
        sys.exit(1)
    sys.exit(import_stadiums(args.csv, dry_run=args.dry_run))


if __name__ == "__main__":
    main()
