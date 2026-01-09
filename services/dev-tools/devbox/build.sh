#!/bin/bash
# Build DevBox custom image

set -e

echo "=========================================="
echo "Building DevBox Image"
echo "=========================================="

# Check if .env exists
if [ ! -f .env ]; then
    echo "No .env file found. Creating from template..."
    cp .env.template .env
    echo "Using default configuration."
fi

# Build the custom image
echo ""
echo "Building image (this may take 5-10 minutes)..."
docker compose build

echo ""
echo "DevBox image built successfully!"
echo ""
echo "Image: outofbanddevelopment/devbox:latest"
echo ""
echo "Installed tools:"
echo "  - Node.js (LTS)"
echo "  - .NET 9.0 SDK"
echo "  - Java 21"
echo "  - Go (configurable)"
echo "  - Rust"
echo "  - PlatformIO"
echo "  - Claude Code CLI"
echo ""
echo "Next steps:"
echo "  Start shell: ./start.sh"
echo "  Check image: docker images | grep devbox"
