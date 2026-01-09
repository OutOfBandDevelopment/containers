#!/bin/bash
set -e
if [ ! -f .env ]; then cp .env.template .env; fi
echo "Starting Node.js development container..."
docker compose run --rm dev-node
