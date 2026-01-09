#!/bin/bash
set -e
echo "=========================================="
echo "Starting TensorFlow Jupyter Lab"
echo "=========================================="
if [ ! -f .env ]; then cp .env.template .env; fi
if ! docker images | grep -q outofbanddevelopment/tensorflow-jupyterlab; then ./build.sh; fi
docker compose up -d
echo ""
echo "TensorFlow Jupyter Lab is starting..."
sleep 10
echo ""
echo "Access Jupyter Lab: http://localhost:8889"
echo "Stop service: ./stop.sh"
