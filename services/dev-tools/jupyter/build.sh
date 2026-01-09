#!/bin/bash
# Build Jupyter Lab custom image

set -e

echo "=========================================="
echo "Building Jupyter Lab Image"
echo "=========================================="

# Check if .env exists
if [ ! -f .env ]; then
    echo "No .env file found. Creating from template..."
    cp .env.template .env
    echo "Using default configuration."
fi

# Build the custom image
docker compose build

echo ""
echo "Jupyter Lab image built successfully!"
echo ""
echo "Image: outofbanddevelopment/jupyter:latest"
echo ""
echo "Next steps:"
echo "  Start service: ./start.sh"
echo "  Check images:  docker images | grep jupyter"
