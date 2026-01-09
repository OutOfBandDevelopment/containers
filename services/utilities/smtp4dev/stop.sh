#!/bin/bash
# Stop SMTP4Dev

set -e

echo "=========================================="
echo "Stopping SMTP4Dev"
echo "=========================================="

docker compose down

echo ""
echo "SMTP4Dev stopped successfully!"
echo ""
echo "Note: Emails are preserved in Docker volumes."
echo "To remove volumes: docker compose down -v"
