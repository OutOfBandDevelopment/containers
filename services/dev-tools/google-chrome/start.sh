#!/bin/bash
set -e
echo "=========================================="
echo "Starting Google Chrome"
echo "=========================================="
if [ ! -f .env ]; then cp .env.template .env; fi
if ! docker images | grep -q outofbanddevelopment/google-chrome; then ./build.sh; fi
echo "NOTE: Requires WSLg (Windows WSL2) or X11 (Linux)"
docker compose up -d
echo ""
echo "Chrome started! Window should appear."
echo "Remote debugging: http://localhost:9223"
