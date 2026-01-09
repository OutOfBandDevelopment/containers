#!/bin/bash
set -e
echo "=========================================="
echo "Building Intel Quartus Image"
echo "=========================================="
echo "NOTE: This only installs dependencies."
echo "You must download Quartus from Intel and update the Dockerfile."
if [ ! -f .env ]; then cp .env.template .env; fi
docker compose build
