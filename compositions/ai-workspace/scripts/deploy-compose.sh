#!/bin/bash
set -e

cd "$(dirname "$0")/.."

echo "=========================================="
echo "Deploying AI Workspace (Docker Compose)"
echo "=========================================="

# Check for .env file
if [ ! -f .env ]; then
    echo "Creating .env from template..."
    cp .env.template .env
    echo ""
    echo "IMPORTANT: Edit .env and configure your settings!"
    echo "Especially change SEARXNG_SECRET before deploying."
    echo ""
    exit 1
fi

echo "Starting services..."
docker compose up -d

echo ""
echo "Waiting for services to be ready..."
sleep 5

echo ""
echo "=========================================="
echo "AI Workspace Status"
echo "=========================================="
docker compose ps

echo ""
echo "=========================================="
echo "Access Points"
echo "=========================================="
echo "Open WebUI:         http://localhost/"
echo "Ollama API:         http://localhost/ollama/"
echo "SearXNG:            http://localhost/searxng/"
echo "Apache Tika:        http://localhost/tika/"
echo "Health Check:       http://localhost/health"
echo ""
echo "Stop services: ./scripts/stop-compose.sh"
echo "=========================================="
