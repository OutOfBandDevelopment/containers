#!/bin/bash
# Stop Apache Tika

set -e

echo "=========================================="
echo "Stopping Apache Tika"
echo "=========================================="

docker compose down

echo ""
echo "Apache Tika stopped successfully!"
