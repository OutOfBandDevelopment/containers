#!/bin/bash
# Start DevBox interactive shell

set -e

echo "=========================================="
echo "Starting DevBox"
echo "=========================================="

# Check if .env exists
if [ ! -f .env ]; then
    echo "No .env file found. Creating from template..."
    cp .env.template .env
fi

# Check if image exists
if ! docker images | grep -q outofbanddevelopment/devbox; then
    echo "DevBox image not found. Building..."
    ./build.sh
fi

echo ""
echo "Starting interactive bash shell..."
echo "All development tools are available:"
echo "  - node, npm, npx"
echo "  - dotnet"
echo "  - java, javac"
echo "  - go"
echo "  - rustc, cargo"
echo "  - pio (PlatformIO)"
echo "  - claude (Claude Code CLI)"
echo ""
echo "Type 'exit' to stop the container."
echo ""

# Start interactive shell
docker compose run --rm devbox
