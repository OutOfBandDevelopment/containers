#!/bin/bash
# Stop LocalStack

set -e

echo "=========================================="
echo "Stopping LocalStack"
echo "=========================================="

docker compose down

echo ""
echo "LocalStack stopped successfully!"
echo ""
echo "Note: Data is preserved in Docker volumes."
echo "To remove volumes: docker compose down -v"
