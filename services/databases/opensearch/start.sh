#!/bin/bash
# Start OpenSearch

set -e

echo "=========================================="
echo "Starting OpenSearch"
echo "=========================================="

# Check if .env exists
if [ ! -f .env ]; then
    echo "No .env file found. Creating from template..."
    cp .env.template .env
    echo "IMPORTANT: Edit .env and change OPENSEARCH_ADMIN_PASSWORD!"
    echo "Then run this script again."
    exit 1
fi

# Check vm.max_map_count
current_max_map_count=$(sysctl vm.max_map_count | awk '{print $3}')
if [ "$current_max_map_count" -lt 262144 ]; then
    echo "WARNING: vm.max_map_count is $current_max_map_count (should be >= 262144)"
    echo "Run: sudo sysctl -w vm.max_map_count=262144"
    echo ""
    read -p "Continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Start service
docker compose up -d

echo ""
echo "OpenSearch started successfully!"
echo ""
echo "Access points:"
echo "  REST API:  http://localhost:9200"
echo "  Username:  admin"
echo "  Password:  (check your .env file)"
echo ""
echo "Check status: docker compose ps"
echo "View logs:    docker compose logs -f"
echo "Stop service: ./stop.sh"
