#!/bin/bash
# Start RabbitMQ

set -e

echo "=========================================="
echo "Starting RabbitMQ"
echo "=========================================="

# Check if .env exists
if [ ! -f .env ]; then
    echo "No .env file found. Creating from template..."
    cp .env.template .env
    echo "IMPORTANT: Edit .env and change RABBITMQ_USER and RABBITMQ_PASSWORD!"
    echo "Then run this script again."
    exit 1
fi

# Start service
docker compose up -d

echo ""
echo "RabbitMQ is starting (this may take 15-20 seconds)..."
sleep 15

echo ""
echo "RabbitMQ started successfully!"
echo ""
echo "Access points:"
echo "  AMQP:         amqp://localhost:5672"
echo "  Management:   http://localhost:15672"
echo "  Username:     (check your .env file)"
echo "  Password:     (check your .env file)"
echo ""
echo "Check status: docker compose ps"
echo "View logs:    docker compose logs -f"
echo "Stop service: ./stop.sh"
