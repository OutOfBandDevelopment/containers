#!/bin/bash
# Stop Microsoft SQL Server

set -e

echo "=========================================="
echo "Stopping Microsoft SQL Server"
echo "=========================================="

docker compose down

echo ""
echo "SQL Server stopped successfully!"
echo ""
echo "Note: Data is preserved in Docker volumes."
echo "To remove volumes: docker compose down -v"
