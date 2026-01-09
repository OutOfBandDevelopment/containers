@echo off
REM Stop Azurite

echo ==========================================
echo Stopping Azurite
echo ==========================================

docker compose down

if errorlevel 1 (
    echo.
    echo Failed to stop Azurite!
    exit /b 1
)

echo.
echo Azurite stopped successfully!
echo.
echo Note: Data is preserved in Docker volumes.
echo To remove volumes: docker compose down -v
