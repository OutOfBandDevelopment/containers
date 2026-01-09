#!/bin/bash
# Stop Jupyter Lab

set -e

echo "=========================================="
echo "Stopping Jupyter Lab"
echo "=========================================="

docker compose down

echo ""
echo "Jupyter Lab stopped successfully!"
echo ""
echo "Note: Notebooks and workspace are preserved in Docker volumes."
echo "To remove volumes: docker compose down -v"
