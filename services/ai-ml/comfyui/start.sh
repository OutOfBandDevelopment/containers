#!/bin/bash
# Start ComfyUI

set -e

echo "=========================================="
echo "Starting ComfyUI"
echo "=========================================="

# Check if .env exists
if [ ! -f .env ]; then
    echo "No .env file found. Creating from template..."
    cp .env.template .env
fi

# Check for NVIDIA GPU
if ! command -v nvidia-smi &> /dev/null; then
    echo "WARNING: nvidia-smi not found. ComfyUI requires NVIDIA GPU and drivers."
    echo "Continuing anyway, but service may not work correctly."
fi

# Start service
docker compose up -d

echo ""
echo "ComfyUI is starting (this may take 30-60 seconds)..."
sleep 30

echo ""
echo "ComfyUI started successfully!"
echo ""
echo "Access ComfyUI: http://localhost:8188"
echo ""
echo "IMPORTANT: Add Stable Diffusion models to comfyui-models volume"
echo "  docker cp model.safetensors comfyui:/root/ComfyUI/models/checkpoints/"
echo ""
echo "Check status: docker compose ps"
echo "View logs:    docker compose logs -f"
echo "Stop service: ./stop.sh"
