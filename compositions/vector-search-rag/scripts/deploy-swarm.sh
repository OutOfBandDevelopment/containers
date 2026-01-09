#!/bin/bash
set -e

echo "=========================================="
echo "Deploying Vector Search RAG (Swarm)"
echo "=========================================="

cd "$(dirname "$0")/.."

if ! docker info | grep -q "Swarm: active"; then
    echo "Docker Swarm not initialized. Run: docker swarm init"
    exit 1
fi

docker stack deploy -c docker-compose.swarm.yml vector-search-rag

echo ""
echo "Stack deployed!"
echo ""
echo "Services:"
docker stack services vector-search-rag
