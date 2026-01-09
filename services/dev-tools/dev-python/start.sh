#!/bin/bash
set -e
if [ ! -f .env ]; then cp .env.template .env; fi
echo "Starting Python development container..."
docker compose run --rm dev-python
