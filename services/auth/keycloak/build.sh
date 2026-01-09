#!/bin/bash
# Build Keycloak

set -e

echo "=========================================="
echo "Building Keycloak"
echo "=========================================="

docker compose build

echo ""
echo "Build complete!"
echo ""
echo "Start service: ./start.sh"
