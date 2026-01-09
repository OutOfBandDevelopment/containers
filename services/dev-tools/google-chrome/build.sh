#!/bin/bash
set -e
echo "=========================================="
echo "Building Google Chrome Image"
echo "=========================================="
if [ ! -f .env ]; then cp .env.template .env; fi
docker compose build
echo ""
echo "Google Chrome image built successfully!"
echo "Next steps: ./start.sh"
