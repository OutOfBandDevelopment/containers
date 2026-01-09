#!/bin/bash
set -e

echo "=========================================="
echo "Deploying Vector Search RAG (Compose)"
echo "=========================================="

cd "$(dirname "$0")/.."

if [ ! -f .env ]; then
    echo "Creating .env from template..."
    cp .env.template .env
    echo "Please edit .env and run again"
    exit 1
fi

docker compose up -d

echo ""
echo "Deployment complete!"
echo ""
echo "Services:"
docker compose ps
echo ""
echo "Access points:"
echo "  Ollama API:      http://localhost:11434"
echo "  Qdrant Dashboard: http://localhost:6333/dashboard"
echo "  SBERT API:       http://localhost:8080"
