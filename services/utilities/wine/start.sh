#!/bin/bash
set -e
echo "=========================================="
echo "Starting Wine"
echo "=========================================="
if [ ! -f .env ]; then cp .env.template .env; fi
if ! docker images | grep -q outofbanddevelopment/wine; then ./build.sh; fi
echo "NOTE: Requires WSLg (WSL2) or X11 (Linux)"
docker compose run --rm wine
