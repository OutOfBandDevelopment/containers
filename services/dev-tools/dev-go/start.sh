#!/bin/bash
set -e
if [ ! -f .env ]; then cp .env.template .env; fi
echo "Starting Go development container..."
docker compose run --rm dev-go
