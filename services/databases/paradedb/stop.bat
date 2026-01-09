@echo off
REM Stop ParadeDB

echo ==========================================
echo Stopping ParadeDB
echo ==========================================

docker compose down

if errorlevel 1 (
    echo.
    echo Failed to stop ParadeDB!
    exit /b 1
)

echo.
echo ParadeDB stopped successfully!
echo.
echo Note: Data is preserved in Docker volumes.
echo To remove volumes: docker compose down -v
