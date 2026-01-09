#!/bin/bash
set -e
echo "=========================================="
echo "Stopping Google Chrome"
echo "=========================================="
docker compose down
echo ""
echo "Chrome stopped. Profile data preserved in volumes."
