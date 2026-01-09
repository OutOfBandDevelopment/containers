#!/bin/bash
# Stop OpenSearch Dashboards

set -e

echo "=========================================="
echo "Stopping OpenSearch Dashboards"
echo "=========================================="

docker compose down

echo ""
echo "OpenSearch Dashboards stopped successfully!"
