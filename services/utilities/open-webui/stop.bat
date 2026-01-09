@echo off
REM Stop Open WebUI

echo ==========================================
echo Stopping Open WebUI
echo ==========================================

docker compose down

if errorlevel 1 (
    echo.
    echo Failed to stop Open WebUI!
    exit /b 1
)

echo.
echo Open WebUI stopped successfully!
echo.
echo Note: Chat history is preserved in Docker volumes.
echo To remove volumes: docker compose down -v
