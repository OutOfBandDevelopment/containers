#!/bin/bash
set -e
echo "=========================================="
echo "Starting SearXNG"
echo "=========================================="
if [ ! -f .env ]; then
    cp .env.template .env
    echo "IMPORTANT: Edit .env and change SEARXNG_SECRET!"
fi
docker compose up -d
echo ""
echo "SearXNG started successfully!"
echo ""
echo "Access SearXNG: http://localhost:8080"
echo ""
echo "Stop service: ./stop.sh"
