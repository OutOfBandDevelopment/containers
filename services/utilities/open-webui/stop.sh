#!/bin/bash
# Stop Open WebUI

set -e

echo "=========================================="
echo "Stopping Open WebUI"
echo "=========================================="

docker compose down

echo ""
echo "Open WebUI stopped successfully!"
echo ""
echo "Note: Chat history is preserved in Docker volumes."
echo "To remove volumes: docker compose down -v"
