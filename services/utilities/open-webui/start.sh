#!/bin/bash
# Start Open WebUI

set -e

echo "=========================================="
echo "Starting Open WebUI"
echo "=========================================="

# Check if .env exists
if [ ! -f .env ]; then
    echo "No .env file found. Creating from template..."
    cp .env.template .env
fi

echo "NOTE: This service requires Ollama to be running."
echo "      Make sure Ollama is accessible at the configured URL."
echo ""

# Start service
docker compose up -d

echo ""
echo "Open WebUI is starting (this may take 10-15 seconds)..."
sleep 10

echo ""
echo "Open WebUI started successfully!"
echo ""
echo "Access point:"
echo "  Web UI: http://localhost:3000"
echo ""
echo "First time? Create an admin account (first user is admin)"
echo ""
echo "Check status: docker compose ps"
echo "View logs:    docker compose logs -f"
echo "Stop service: ./stop.sh"
