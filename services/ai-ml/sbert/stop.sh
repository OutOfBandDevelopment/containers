#!/bin/bash
# Stop SBERT

set -e

echo "Stopping SBERT..."
docker compose --profile cpu --profile gpu down

echo "✓ SBERT stopped"
