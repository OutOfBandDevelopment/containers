#!/bin/bash
# Start Qdrant Vector Database

set -e

echo "=========================================="
echo "Starting Qdrant Vector Database"
echo "=========================================="

# Check if .env exists
if [ ! -f .env ]; then
    echo "No .env file found. Creating from template..."
    cp .env.template .env
    echo "Please edit .env with your settings and run again."
    exit 1
fi

# Start service
docker compose up -d

echo ""
echo "Qdrant started successfully!"
echo ""
echo "Access points:"
echo "  REST API:  http://localhost:6333"
echo "  gRPC API:  localhost:6334"
echo "  Dashboard: http://localhost:6333/dashboard"
echo ""
echo "Check status: docker compose ps"
echo "View logs:    docker compose logs -f"
echo "Stop service: ./stop.sh"
