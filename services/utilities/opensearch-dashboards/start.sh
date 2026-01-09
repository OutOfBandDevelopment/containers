#!/bin/bash
# Start OpenSearch Dashboards

set -e

echo "=========================================="
echo "Starting OpenSearch Dashboards"
echo "=========================================="

# Check if .env exists
if [ ! -f .env ]; then
    echo "No .env file found. Creating from template..."
    cp .env.template .env
fi

echo "NOTE: This service requires OpenSearch to be running."
echo "      Make sure OpenSearch is accessible at the configured host."
echo ""

# Start service
docker compose up -d

echo ""
echo "OpenSearch Dashboards is starting (this may take 10-15 seconds)..."
sleep 10

echo ""
echo "OpenSearch Dashboards started successfully!"
echo ""
echo "Access point:"
echo "  Web UI: http://localhost:5601"
echo ""
echo "Check status: docker compose ps"
echo "View logs:    docker compose logs -f"
echo "Stop service: ./stop.sh"
