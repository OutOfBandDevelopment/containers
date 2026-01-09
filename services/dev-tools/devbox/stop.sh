#!/bin/bash
# Stop DevBox

set -e

echo "=========================================="
echo "Stopping DevBox"
echo "=========================================="

# DevBox runs with --rm flag, so containers are automatically removed on exit
# This script stops any running instances

docker compose down

echo ""
echo "DevBox stopped successfully!"
echo ""
echo "Note: Project files and package caches are preserved in Docker volumes."
echo "To remove volumes: docker compose down -v"
