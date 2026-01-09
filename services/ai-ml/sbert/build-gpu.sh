#!/bin/bash
# Build SBERT GPU (CUDA) image

set -e

echo "Building SBERT (GPU/CUDA)..."
docker compose build sbert-gpu

echo "✓ SBERT GPU image built successfully"
echo "  Image: local/sbert:cuda"
echo ""
echo "To start: ./start-gpu.sh"
