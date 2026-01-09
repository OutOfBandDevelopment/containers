#!/bin/bash
# Start GNU COBOL interactive shell

set -e

echo "=========================================="
echo "Starting GNU COBOL"
echo "=========================================="

if [ ! -f .env ]; then
    cp .env.template .env
fi

if ! docker images | grep -q outofbanddevelopment/gnucobol; then
    echo "GNU COBOL image not found. Building..."
    ./build.sh
fi

echo ""
echo "Starting interactive bash shell..."
echo "COBOL compiler available: cobc, cobcrun"
echo ""
echo "Type 'exit' to stop the container."
echo ""

docker compose run --rm gnucobol
