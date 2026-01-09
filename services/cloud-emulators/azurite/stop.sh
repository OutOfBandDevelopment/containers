#!/bin/bash
# Stop Azurite

set -e

echo "=========================================="
echo "Stopping Azurite"
echo "=========================================="

docker compose down

echo ""
echo "Azurite stopped successfully!"
echo ""
echo "Note: Data is preserved in Docker volumes."
echo "To remove volumes: docker compose down -v"
