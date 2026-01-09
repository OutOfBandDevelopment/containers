#!/bin/bash
set -e
if [ ! -f .env ]; then cp .env.template .env; fi
if ! docker images | grep -q outofbanddevelopment/vivado; then ./build.sh; fi
echo "Starting Vivado container (WSLg/X11 required)..."
docker compose run --rm vivado
