#!/bin/bash
set -e
echo "=========================================="
echo "Building Wine Image"
echo "=========================================="
if [ ! -f .env ]; then cp .env.template .env; fi
echo "Building (this may take 5-10 minutes)..."
docker compose build
echo ""
echo "Wine image built successfully!"
