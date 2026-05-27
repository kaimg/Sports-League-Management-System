"""Wait until PostgreSQL accepts connections (used on container startup)."""

from __future__ import annotations

import os
import sys
import time

import psycopg2


def main() -> int:
    database_url = os.getenv("DATABASE_URL")
    if not database_url:
        print("DATABASE_URL is not set.", file=sys.stderr)
        return 1

    timeout = int(os.getenv("DB_WAIT_TIMEOUT", "120"))
    interval = float(os.getenv("DB_WAIT_INTERVAL", "2"))
    deadline = time.monotonic() + timeout

    while time.monotonic() < deadline:
        try:
            conn = psycopg2.connect(database_url)
            conn.close()
            print("Database is ready.")
            return 0
        except psycopg2.OperationalError as exc:
            print(f"Waiting for database... ({exc})")
            time.sleep(interval)

    print(f"Database not ready after {timeout}s.", file=sys.stderr)
    return 1


if __name__ == "__main__":
    raise SystemExit(main())
