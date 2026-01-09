#!/bin/bash
# Stop Keycloak

set -e

echo "=========================================="
echo "Stopping Keycloak"
echo "=========================================="

docker compose down

echo ""
echo "Keycloak stopped successfully!"
echo ""
echo "Note: Data is preserved in Docker volumes."
echo "To remove volumes: docker compose down -v"
