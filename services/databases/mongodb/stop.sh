#!/bin/bash
# Stop MongoDB

set -e

echo "=========================================="
echo "Stopping MongoDB"
echo "=========================================="

docker compose down

echo ""
echo "MongoDB stopped successfully!"
echo ""
echo "Note: Data is preserved in Docker volumes."
echo "To remove volumes: docker compose down -v"
