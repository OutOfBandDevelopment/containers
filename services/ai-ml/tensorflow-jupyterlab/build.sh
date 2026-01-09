#!/bin/bash
set -e
echo "=========================================="
echo "Building TensorFlow Jupyter Lab Image"
echo "=========================================="
if [ ! -f .env ]; then cp .env.template .env; fi
docker compose build
echo ""
echo "TensorFlow Jupyter Lab image built successfully!"
echo "Next steps: ./start.sh"
