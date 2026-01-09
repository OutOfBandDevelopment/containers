#!/bin/bash
# Build SBERT CPU image

set -e

echo "Building SBERT (CPU)..."
docker compose build sbert-cpu

echo "✓ SBERT CPU image built successfully"
echo "  Image: local/sbert:cpu"
echo ""
echo "To start: ./start-cpu.sh"
