@echo off
REM Stop RabbitMQ

echo ==========================================
echo Stopping RabbitMQ
echo ==========================================

docker compose down

if errorlevel 1 (
    echo.
    echo Failed to stop RabbitMQ!
    exit /b 1
)

echo.
echo RabbitMQ stopped successfully!
echo.
echo Note: Data is preserved in Docker volumes.
echo To remove volumes: docker compose down -v
