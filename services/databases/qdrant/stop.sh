#!/bin/bash
# Stop Qdrant Vector Database

set -e

echo "=========================================="
echo "Stopping Qdrant Vector Database"
echo "=========================================="

docker compose down

echo ""
echo "Qdrant stopped successfully!"
echo ""
echo "Note: Data is preserved in Docker volumes."
echo "To remove volumes: docker compose down -v"
