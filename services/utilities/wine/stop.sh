#!/bin/bash
set -e
echo "=========================================="
echo "Stopping Wine"
echo "=========================================="
docker compose down
echo ""
echo "Wine stopped. Wine prefix preserved in volumes."
