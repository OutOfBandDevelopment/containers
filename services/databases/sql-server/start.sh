#!/bin/bash
# Start Microsoft SQL Server

set -e

echo "=========================================="
echo "Starting Microsoft SQL Server"
echo "=========================================="

# Check if .env exists
if [ ! -f .env ]; then
    echo "No .env file found. Creating from template..."
    cp .env.template .env
    echo "IMPORTANT: Edit .env and change MSSQL_SA_PASSWORD!"
    echo "Password must be at least 8 characters with uppercase, lowercase, digits, and symbols."
    echo "Then run this script again."
    exit 1
fi

# Start service
docker compose up -d

echo ""
echo "SQL Server is starting (this may take 30-60 seconds)..."
echo ""
echo "Waiting for SQL Server to be ready..."
sleep 10

# Check if SQL Server is ready
for i in {1..12}; do
    if docker exec sql-server /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "${MSSQL_SA_PASSWORD:-YourStrong@Passw0rd}" -Q "SELECT 1" > /dev/null 2>&1; then
        echo ""
        echo "SQL Server started successfully!"
        echo ""
        echo "Connection details:"
        echo "  Server:   localhost,1433"
        echo "  Username: sa"
        echo "  Password: (check your .env file)"
        echo ""
        echo "Connect with sqlcmd:"
        echo "  docker exec -it sql-server /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'YourPassword'"
        echo ""
        echo "Check status: docker compose ps"
        echo "View logs:    docker compose logs -f"
        echo "Stop service: ./stop.sh"
        exit 0
    fi
    echo "Still starting... ($i/12)"
    sleep 5
done

echo ""
echo "SQL Server may still be starting. Check logs:"
echo "  docker compose logs -f"
