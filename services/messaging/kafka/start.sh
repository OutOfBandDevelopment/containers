#!/bin/bash
# Start Apache Kafka

set -e

echo "=========================================="
echo "Starting Apache Kafka (KRaft mode)"
echo "=========================================="

# Check if .env exists
if [ ! -f .env ]; then
    echo "No .env file found. Creating from template..."
    cp .env.template .env
fi

# Start service
docker compose up -d

echo ""
echo "Kafka is starting (this may take 20-30 seconds)..."
sleep 20

echo ""
echo "Kafka started successfully!"
echo ""
echo "Connection details:"
echo "  Internal: localhost:9092"
echo "  External: localhost:9094"
echo ""
echo "Create a topic:"
echo "  docker exec kafka kafka-topics.sh --create --bootstrap-server localhost:9092 --topic my-topic"
echo ""
echo "List topics:"
echo "  docker exec kafka kafka-topics.sh --list --bootstrap-server localhost:9092"
echo ""
echo "Check status: docker compose ps"
echo "View logs:    docker compose logs -f"
echo "Stop service: ./stop.sh"
