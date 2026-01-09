#!/bin/bash
set -e
echo "=========================================="
echo "Starting PlantUML Server"
echo "=========================================="
if [ ! -f .env ]; then
    cp .env.template .env
    echo "Created .env from template"
fi
docker compose up -d
echo ""
echo "PlantUML Server started successfully!"
echo ""
echo "Access PlantUML: http://localhost:8080"
echo ""
echo "Stop service: ./stop.sh"
