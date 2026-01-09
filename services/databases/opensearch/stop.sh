#!/bin/bash
# Stop OpenSearch

set -e

echo "=========================================="
echo "Stopping OpenSearch"
echo "=========================================="

docker compose down

echo ""
echo "OpenSearch stopped successfully!"
echo ""
echo "Note: Data is preserved in Docker volumes."
echo "To remove volumes: docker compose down -v"
