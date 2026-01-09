#!/bin/bash
# Start SMTP4Dev

set -e

echo "=========================================="
echo "Starting SMTP4Dev"
echo "=========================================="

# Check if .env exists
if [ ! -f .env ]; then
    echo "No .env file found. Creating from template..."
    cp .env.template .env
fi

# Start service
docker compose up -d

echo ""
echo "SMTP4Dev started successfully!"
echo ""
echo "Access points:"
echo "  Web UI:  http://localhost:7777"
echo "  SMTP:    localhost:25"
echo "  IMAP:    localhost:143"
echo "  POP3:    localhost:110"
echo ""
echo "Send test emails to SMTP port 25 and view them in the web UI."
echo ""
echo "Check status: docker compose ps"
echo "View logs:    docker compose logs -f"
echo "Stop service: ./stop.sh"
