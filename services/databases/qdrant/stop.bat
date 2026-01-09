@echo off
REM Stop Qdrant Vector Database

echo ==========================================
echo Stopping Qdrant Vector Database
echo ==========================================

docker compose down

if errorlevel 1 (
    echo.
    echo Failed to stop Qdrant!
    exit /b 1
)

echo.
echo Qdrant stopped successfully!
echo.
echo Note: Data is preserved in Docker volumes.
echo To remove volumes: docker compose down -v
