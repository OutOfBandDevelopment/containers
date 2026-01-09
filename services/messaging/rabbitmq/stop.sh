#!/bin/bash
# Stop RabbitMQ

set -e

echo "=========================================="
echo "Stopping RabbitMQ"
echo "=========================================="

docker compose down

echo ""
echo "RabbitMQ stopped successfully!"
echo ""
echo "Note: Data is preserved in Docker volumes."
echo "To remove volumes: docker compose down -v"
