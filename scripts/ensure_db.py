"""Ensure the database schema exists and is up to date."""

from __future__ import annotations

import glob
import os
import subprocess
import sys
import time
from pathlib import Path
from urllib.parse import urlparse

import psycopg2

APP_ROLE = "sports_league_owner"
DEFAULT_APP_PASSWORD = "sports_league_password"

REQUIRED_TABLES = (
    "users",
    "teams",
    "leagues",
    "matches",
    "stadiums",
    "players",
    "scores",
    "standings",
    "user_favorites",
    "notifications",
)

PROJECT_ROOT = Path(__file__).resolve().parent.parent
SCHEMA_FILE = PROJECT_ROOT / "schema.sql"
MIGRATIONS_DIR = PROJECT_ROOT / "migrations"


def parse_database_url(url: str) -> dict[str, str]:
    parsed = urlparse(url)
    if parsed.scheme not in ("postgresql", "postgres"):
        raise ValueError(f"Unsupported DATABASE_URL scheme: {parsed.scheme}")

    return {
        "host": parsed.hostname or "localhost",
        "port": str(parsed.port or 5432),
        "user": parsed.username or "",
        "password": parsed.password or "",
        "dbname": (parsed.path or "/").lstrip("/"),
    }


def wait_for_database(database_url: str, timeout: int = 120) -> None:
    deadline = time.monotonic() + timeout
    while time.monotonic() < deadline:
        try:
            conn = psycopg2.connect(database_url)
            conn.close()
            return
        except psycopg2.OperationalError as exc:
            print(f"Waiting for database... ({exc})")
            time.sleep(2)

    raise TimeoutError(f"Database not reachable after {timeout}s.")


def ensure_app_role(database_url: str) -> None:
    """schema.sql expects the sports_league_owner role to exist."""
    params = parse_database_url(database_url)
    if params["user"] == APP_ROLE:
        return

    app_password = (
        os.getenv("SPORTS_LEAGUE_OWNER_PASSWORD")
        or os.getenv("POSTGRES_APP_PASSWORD")
        or DEFAULT_APP_PASSWORD
    )

    with psycopg2.connect(database_url) as conn:
        conn.autocommit = True
        with conn.cursor() as cur:
            cur.execute(
                "SELECT 1 FROM pg_catalog.pg_roles WHERE rolname = %s",
                (APP_ROLE,),
            )
            if cur.fetchone():
                print(f"Role '{APP_ROLE}' already exists.")
                return

            print(f"Creating role '{APP_ROLE}' required by schema.sql...")
            cur.execute(
                f"CREATE ROLE {APP_ROLE} WITH LOGIN PASSWORD %s SUPERUSER",
                (app_password,),
            )


def get_existing_tables(database_url: str) -> set[str]:
    with psycopg2.connect(database_url) as conn:
        with conn.cursor() as cur:
            cur.execute(
                """
                SELECT table_name
                FROM information_schema.tables
                WHERE table_schema = 'public'
                """
            )
            return {row[0] for row in cur.fetchall()}


def run_psql_file(database_url: str, sql_file: Path) -> None:
    params = parse_database_url(database_url)
    env = os.environ.copy()
    env["PGPASSWORD"] = params["password"]

    command = [
        "psql",
        "-v",
        "ON_ERROR_STOP=1",
        "-h",
        params["host"],
        "-p",
        params["port"],
        "-U",
        params["user"],
        "-d",
        params["dbname"],
        # schema.sql clears search_path; PostGIS types live in public.
        "-c",
        "SET search_path TO public;",
        "-f",
        str(sql_file),
    ]

    print(f"Applying {sql_file.name}...")
    subprocess.run(command, env=env, check=True)


def run_migrations(database_url: str) -> None:
    if not MIGRATIONS_DIR.is_dir():
        return

    for migration in sorted(glob.glob(str(MIGRATIONS_DIR / "*.sql"))):
        run_psql_file(database_url, Path(migration))


def fix_sequences(database_url: str) -> None:
    tables_and_seqs = [
        ("standings", "standings_standing_id_seq", "standing_id"),
        ("scorers", "scorers_scorer_id_seq", "scorer_id"),
        ("seasons", "seasons_season_id_seq", "season_id"),
        ("teams", "teams_team_id_seq", "team_id"),
        ("players", "players_player_id_seq", "player_id"),
        ("matches", "matches_match_id_seq", "match_id"),
        ("scores", "scores_score_id_seq", "score_id"),
    ]

    with psycopg2.connect(database_url) as conn:
        with conn.cursor() as cur:
            for table, seq, pk in tables_and_seqs:
                cur.execute(
                    f"SELECT setval('{seq}', COALESCE((SELECT MAX({pk}) FROM {table}), 1))"
                )
        conn.commit()
    print("Database sequences synchronized.")


def main() -> int:
    from dotenv import load_dotenv

    load_dotenv()

    database_url = os.getenv("DATABASE_URL")
    if not database_url:
        print("DATABASE_URL is not set.", file=sys.stderr)
        return 1

    if not SCHEMA_FILE.is_file():
        print(f"Schema file not found: {SCHEMA_FILE}", file=sys.stderr)
        return 1

    try:
        wait_for_database(database_url)
        ensure_app_role(database_url)
    except TimeoutError as exc:
        print(str(exc), file=sys.stderr)
        return 1

    existing = get_existing_tables(database_url)
    missing = [table for table in REQUIRED_TABLES if table not in existing]
    existing_required = {table for table in REQUIRED_TABLES if table in existing}

    if not missing:
        print("Database schema already present.")
        run_migrations(database_url)
        fix_sequences(database_url)
        return 0

    if existing_required:
        print(
            "Partial database detected (some application tables exist, others are missing).",
            file=sys.stderr,
        )
        print(
            "Reset the database and run setup again:\n"
            "  Docker:  docker compose down -v  then  .\\setup.ps1 -Fresh  or  ./setup.sh --fresh\n"
            "  Local:   drop/recreate the DB, then  python scripts/ensure_db.py",
            file=sys.stderr,
        )
        return 1

    print("Initializing database schema...")
    run_psql_file(database_url, SCHEMA_FILE)
    run_migrations(database_url)
    fix_sequences(database_url)
    print("Database initialized successfully.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
