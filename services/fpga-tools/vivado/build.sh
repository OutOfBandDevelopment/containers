#!/bin/bash
set -e
echo "=========================================="
echo "Building AMD/Xilinx Vivado Image"
echo "=========================================="
echo "NOTE: This only installs dependencies."
echo "You must download Vivado from AMD/Xilinx and update the Dockerfile."
if [ ! -f .env ]; then cp .env.template .env; fi
docker compose build
