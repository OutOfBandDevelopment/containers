#!/bin/bash
# Stop Apache Kafka

set -e

echo "=========================================="
echo "Stopping Apache Kafka"
echo "=========================================="

docker compose down

echo ""
echo "Kafka stopped successfully!"
echo ""
echo "Note: Data is preserved in Docker volumes."
echo "To remove volumes: docker compose down -v"
