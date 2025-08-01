#!/bin/bash

# Exit on any failure
set -e

echo "🔍 Checking .env file..."
if [ ! -f .env ]; then
    echo "⚠️  Creating .env from .env.example"
    cp .env.example .env
    echo "➡️  Please edit the .env file with your environment variables before continuing."
    exit 1
fi

echo "🔄 Checking if Docker is running..."
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker and try again."
    exit 1
fi

# Optional: make init scripts executable (harmless if unused)
chmod +x 1-init-admin.sh 2>/dev/null || true
chmod +x 3-restore-dump.sh 2>/dev/null || true

echo "🚀 Starting containers..."
docker compose up --build -d

echo ""
echo "✅ Setup complete. App should be available at: http://localhost:8888"

