#!/bin/bash
# Start Azurite

set -e

echo "=========================================="
echo "Starting Azurite (Azure Storage Emulator)"
echo "=========================================="

# Check if .env exists
if [ ! -f .env ]; then
    echo "No .env file found. Creating from template..."
    cp .env.template .env
fi

# Start service
docker compose up -d

echo ""
echo "Azurite started successfully!"
echo ""
echo "Services:"
echo "  Blob:  http://localhost:10000"
echo "  Queue: http://localhost:10001"
echo "  Table: http://localhost:10002"
echo ""
echo "Default Account:"
echo "  Name: devstoreaccount1"
echo "  Key:  Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw=="
echo ""
echo "Check status: docker compose ps"
echo "View logs:    docker compose logs -f"
echo "Stop service: ./stop.sh"
