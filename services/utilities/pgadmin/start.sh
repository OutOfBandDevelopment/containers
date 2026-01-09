#!/bin/bash
# Start pgAdmin

set -e

echo "=========================================="
echo "Starting pgAdmin"
echo "=========================================="

# Check if .env exists
if [ ! -f .env ]; then
    echo "No .env file found. Creating from template..."
    cp .env.template .env
    echo "IMPORTANT: Edit .env and change PGADMIN_EMAIL and PGADMIN_PASSWORD!"
    echo "Then run this script again."
    exit 1
fi

# Start service
docker compose up -d

echo ""
echo "pgAdmin is starting (this may take 5-10 seconds)..."
sleep 5

echo ""
echo "pgAdmin started successfully!"
echo ""
echo "Access point:"
echo "  Web UI: http://localhost:8082"
echo "  Email:  (check your .env file)"
echo "  Password: (check your .env file)"
echo ""
echo "Check status: docker compose ps"
echo "View logs:    docker compose logs -f"
echo "Stop service: ./stop.sh"
