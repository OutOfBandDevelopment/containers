#!/bin/bash
# Stop ComfyUI

set -e

echo "=========================================="
echo "Stopping ComfyUI"
echo "=========================================="

docker compose down

echo ""
echo "ComfyUI stopped successfully!"
echo ""
echo "Note: Models and generated images are preserved in Docker volumes."
echo "To remove volumes: docker compose down -v"
