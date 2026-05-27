#!/usr/bin/env bash
set -euo pipefail

FRESH=0

for arg in "$@"; do
    case "$arg" in
        --fresh|-f)
            FRESH=1
            ;;
        -h|--help)
            echo "Usage: ./setup.sh [--fresh]"
            echo "  --fresh  Remove containers and database volume before setup"
            exit 0
            ;;
        *)
            echo "Unknown option: $arg" >&2
            exit 1
            ;;
    esac
done

compose() {
    if docker compose version >/dev/null 2>&1; then
        docker compose "$@"
    else
        docker-compose "$@"
    fi
}

if [ ! -f .env ]; then
    echo "Creating .env file from .env.example..."
    cp .env.example .env
    echo "Please edit .env and set your environment variables, then run ./setup.sh again."
    exit 1
fi

if ! docker info >/dev/null 2>&1; then
    echo "Docker is not running. Please start Docker and try again."
    exit 1
fi

if [ "$FRESH" -eq 1 ]; then
    echo "Removing existing containers and database volume..."
    compose down -v
fi

echo "Building and starting containers..."
compose up --build -d

echo "Waiting for PostgreSQL..."
for _ in $(seq 1 60); do
    if compose exec -T db sh -c 'pg_isready -U "$POSTGRES_USER" -d "$POSTGRES_DB"' >/dev/null 2>&1; then
        break
    fi
    sleep 2
done

echo "Initializing database schema..."
if ! compose run --rm web python scripts/wait_for_db.py; then
    echo "Could not connect to the database from the web container." >&2
    exit 1
fi

if ! compose run --rm web python scripts/ensure_db.py; then
    echo ""
    echo "Database initialization failed."
    echo "If the database was partially created, reset and retry:"
    echo "  ./setup.sh --fresh"
    exit 1
fi

echo "Starting web application..."
compose up -d web

echo ""
echo "Setup complete. Application: http://localhost:5000"
echo "View logs: docker compose logs -f web"
