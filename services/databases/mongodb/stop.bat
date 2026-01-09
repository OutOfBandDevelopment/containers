@echo off
REM Stop MongoDB

echo ==========================================
echo Stopping MongoDB
echo ==========================================

docker compose down

if errorlevel 1 (
    echo.
    echo Failed to stop MongoDB!
    exit /b 1
)

echo.
echo MongoDB stopped successfully!
echo.
echo Note: Data is preserved in Docker volumes.
echo To remove volumes: docker compose down -v
