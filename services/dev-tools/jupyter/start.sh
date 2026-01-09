#!/bin/bash
# Start Jupyter Lab

set -e

echo "=========================================="
echo "Starting Jupyter Lab"
echo "=========================================="

# Check if .env exists
if [ ! -f .env ]; then
    echo "No .env file found. Creating from template..."
    cp .env.template .env
fi

# Check if image exists
if ! docker images | grep -q outofbanddevelopment/jupyter; then
    echo "Jupyter Lab image not found. Building..."
    ./build.sh
fi

# Start service
docker compose up -d

echo ""
echo "Jupyter Lab is starting (this may take 10-15 seconds)..."
sleep 10

echo ""
echo "Jupyter Lab started successfully!"
echo ""
echo "Access Jupyter Lab: http://localhost:8888"
echo ""
echo "Available kernels:"
echo "  - Python 3 (with PyTorch, TensorFlow)"
echo "  - .NET (C#)"
echo "  - Java"
echo "  - Go"
echo "  - Ruby"
echo "  - TypeScript/JavaScript"
echo ""
echo "Check status: docker compose ps"
echo "View logs:    docker compose logs -f"
echo "Stop service: ./stop.sh"
