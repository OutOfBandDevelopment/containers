#!/bin/bash
# Start SBERT (GPU/CUDA)

set -e

echo "Starting SBERT (GPU/CUDA)..."
docker compose --profile gpu up -d

echo "✓ SBERT GPU started"
echo "  URL: http://localhost:${SBERT_PORT:-8080}"
echo ""
echo "To stop: ./stop.sh"
