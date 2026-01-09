@echo off
REM Stop LocalStack

echo ==========================================
echo Stopping LocalStack
echo ==========================================

docker compose down

if errorlevel 1 (
    echo.
    echo Failed to stop LocalStack!
    exit /b 1
)

echo.
echo LocalStack stopped successfully!
echo.
echo Note: Data is preserved in Docker volumes.
echo To remove volumes: docker compose down -v
