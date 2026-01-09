#!/bin/bash
# Start SBERT (CPU)

set -e

echo "Starting SBERT (CPU)..."
docker compose --profile cpu up -d

echo "✓ SBERT CPU started"
echo "  URL: http://localhost:${SBERT_PORT:-8080}"
echo ""
echo "To stop: ./stop.sh"
