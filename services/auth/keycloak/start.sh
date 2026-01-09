#!/bin/bash
# Start Keycloak

set -e

echo "=========================================="
echo "Starting Keycloak"
echo "=========================================="

# Check if .env exists
if [ ! -f .env ]; then
    echo "No .env file found. Creating from template..."
    cp .env.template .env
    echo "IMPORTANT: Edit .env and change KEYCLOAK_ADMIN_PASSWORD!"
    echo "Then run this script again."
    exit 1
fi

# Start service
docker compose up -d

echo ""
echo "Keycloak is starting (this may take 30-60 seconds)..."
sleep 30

echo ""
echo "Keycloak started successfully!"
echo ""
echo "Access points:"
echo "  Admin Console: http://localhost:8081"
echo "  Realm:         local-dev"
echo "  Username:      admin"
echo "  Password:      (check your .env file)"
echo ""
echo "Check status: docker compose ps"
echo "View logs:    docker compose logs -f"
echo "Stop service: ./stop.sh"
