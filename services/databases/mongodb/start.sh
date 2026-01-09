#!/bin/bash
# Start MongoDB

set -e

echo "=========================================="
echo "Starting MongoDB"
echo "=========================================="

# Check if .env exists
if [ ! -f .env ]; then
    echo "No .env file found. Creating from template..."
    cp .env.template .env
    echo "IMPORTANT: Edit .env and change credentials!"
    echo "Then run this script again."
    exit 1
fi

# Start service
docker compose up -d

echo ""
echo "MongoDB is starting (this may take 10-15 seconds)..."
sleep 10

echo ""
echo "MongoDB started successfully!"
echo ""
echo "Connection details:"
echo "  Host:     localhost"
echo "  Port:     27017"
echo "  Username: admin"
echo "  Password: (check your .env file)"
echo ""
echo "Connect with mongosh:"
echo "  docker exec -it mongodb mongosh -u admin -p 'YourPassword'"
echo ""
echo "Or from host:"
echo "  mongosh \"mongodb://admin:YourPassword@localhost:27017\""
echo ""
echo "MongoDB Compass:"
echo "  mongodb://admin:YourPassword@localhost:27017"
echo ""
echo "Check status: docker compose ps"
echo "View logs:    docker compose logs -f"
echo "Stop service: ./stop.sh"
