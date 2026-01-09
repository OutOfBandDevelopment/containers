#!/bin/bash
# Stop pgAdmin

set -e

echo "=========================================="
echo "Stopping pgAdmin"
echo "=========================================="

docker compose down

echo ""
echo "pgAdmin stopped successfully!"
echo ""
echo "Note: Data is preserved in Docker volumes."
echo "To remove volumes: docker compose down -v"
