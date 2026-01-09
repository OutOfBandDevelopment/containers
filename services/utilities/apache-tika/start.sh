#!/bin/bash
# Start Apache Tika

set -e

echo "=========================================="
echo "Starting Apache Tika"
echo "=========================================="

# Check if .env exists
if [ ! -f .env ]; then
    echo "No .env file found. Creating from template..."
    cp .env.template .env
fi

# Start service
docker compose up -d

echo ""
echo "Apache Tika started successfully!"
echo ""
echo "Access point:"
echo "  REST API: http://localhost:9998"
echo ""
echo "Test with:"
echo "  curl http://localhost:9998/tika"
echo ""
echo "Check status: docker compose ps"
echo "View logs:    docker compose logs -f"
echo "Stop service: ./stop.sh"
