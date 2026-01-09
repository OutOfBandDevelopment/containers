#!/bin/bash
# Build GNU COBOL custom image

set -e

echo "=========================================="
echo "Building GNU COBOL Image"
echo "=========================================="

if [ ! -f .env ]; then
    cp .env.template .env
    echo "Using default configuration."
fi

docker compose build

echo ""
echo "GNU COBOL image built successfully!"
echo ""
echo "Image: outofbanddevelopment/gnucobol:latest"
echo ""
echo "Next steps:"
echo "  Start shell: ./start.sh"
