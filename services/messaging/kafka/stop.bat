@echo off
REM Stop Apache Kafka

echo ==========================================
echo Stopping Apache Kafka
echo ==========================================

docker compose down

if errorlevel 1 (
    echo.
    echo Failed to stop Kafka!
    exit /b 1
)

echo.
echo Kafka stopped successfully!
echo.
echo Note: Data is preserved in Docker volumes.
echo To remove volumes: docker compose down -v
