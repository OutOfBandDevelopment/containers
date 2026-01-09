@echo off
REM Stop pgAdmin

echo ==========================================
echo Stopping pgAdmin
echo ==========================================

docker compose down

if errorlevel 1 (
    echo.
    echo Failed to stop pgAdmin!
    exit /b 1
)

echo.
echo pgAdmin stopped successfully!
echo.
echo Note: Data is preserved in Docker volumes.
echo To remove volumes: docker compose down -v
