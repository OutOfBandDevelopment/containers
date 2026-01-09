#!/bin/bash
# Stop GNU COBOL

set -e

echo "=========================================="
echo "Stopping GNU COBOL"
echo "=========================================="

docker compose down

echo ""
echo "GNU COBOL stopped successfully!"
echo ""
echo "Note: COBOL source files are preserved in Docker volumes."
echo "To remove volumes: docker compose down -v"
