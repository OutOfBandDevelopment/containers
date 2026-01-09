#!/bin/bash
# Start ParadeDB

set -e

echo "=========================================="
echo "Starting ParadeDB"
echo "=========================================="

# Check if .env exists
if [ ! -f .env ]; then
    echo "No .env file found. Creating from template..."
    cp .env.template .env
    echo "IMPORTANT: Edit .env and change passwords!"
    echo "Then run this script again."
    exit 1
fi

# Start service
docker compose up -d

echo ""
echo "ParadeDB is starting (this may take 10-20 seconds)..."
sleep 10

echo ""
echo "ParadeDB started successfully!"
echo ""
echo "Connection details:"
echo "  Host:     localhost"
echo "  Port:     5432"
echo "  Database: paradedb"
echo "  Username: admin"
echo "  Password: (check your .env file)"
echo ""
echo "Connect with psql:"
echo "  docker exec -it paradedb psql -U admin -d paradedb"
echo ""
echo "Or from host:"
echo "  psql -h localhost -p 5432 -U admin -d paradedb"
echo ""
echo "Check status: docker compose ps"
echo "View logs:    docker compose logs -f"
echo "Stop service: ./stop.sh"
