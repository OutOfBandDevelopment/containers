#!/bin/bash
set -e

cd "$(dirname "$0")/.."

echo "=========================================="
echo "Deploying AI Workspace (Docker Swarm)"
echo "=========================================="

# Check for .env file
if [ ! -f .env ]; then
    echo "Creating .env from template..."
    cp .env.template .env
    echo ""
    echo "IMPORTANT: Edit .env and configure your settings!"
    echo ""
    exit 1
fi

# Source environment variables
set -a
source .env
set +a

echo "Deploying stack to Swarm..."
docker stack deploy -c docker-compose.swarm.yml ai-workspace

echo ""
echo "Waiting for services to start..."
sleep 10

echo ""
echo "=========================================="
echo "AI Workspace Stack Status"
echo "=========================================="
docker stack services ai-workspace

echo ""
echo "=========================================="
echo "Access Points"
echo "=========================================="
echo "Open WebUI:         http://localhost/"
echo "Ollama API:         http://localhost/ollama/"
echo "SearXNG:            http://localhost/searxng/"
echo "Apache Tika:        http://localhost/tika/"
echo ""
echo "Check logs:         docker service logs ai-workspace_<service>"
echo "Remove stack:       ./scripts/remove-swarm.sh"
echo "=========================================="
