#!/bin/bash
set -e
if [ ! -f .env ]; then cp .env.template .env; fi
if ! docker images | grep -q outofbanddevelopment/quartus; then ./build.sh; fi
echo "Starting Quartus container (WSLg/X11 required)..."
docker compose run --rm quartus
