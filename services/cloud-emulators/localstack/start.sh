#!/bin/bash
# Start LocalStack

set -e

echo "=========================================="
echo "Starting LocalStack (AWS Emulator)"
echo "=========================================="

# Check if .env exists
if [ ! -f .env ]; then
    echo "No .env file found. Creating from template..."
    cp .env.template .env
fi

# Start service
docker compose up -d

echo ""
echo "LocalStack is starting (this may take 20-30 seconds)..."
sleep 20

echo ""
echo "LocalStack started successfully!"
echo ""
echo "API Endpoint: http://localhost:4566"
echo ""
echo "Test with AWS CLI:"
echo "  aws --endpoint-url=http://localhost:4566 s3 ls"
echo ""
echo "Health check:"
echo "  curl http://localhost:4566/_localstack/health"
echo ""
echo "Check status: docker compose ps"
echo "View logs:    docker compose logs -f"
echo "Stop service: ./stop.sh"
