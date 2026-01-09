#!/bin/bash
# Stop ParadeDB

set -e

echo "=========================================="
echo "Stopping ParadeDB"
echo "=========================================="

docker compose down

echo ""
echo "ParadeDB stopped successfully!"
echo ""
echo "Note: Data is preserved in Docker volumes."
echo "To remove volumes: docker compose down -v"
