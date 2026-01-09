@echo off
REM Stop Microsoft SQL Server

echo ==========================================
echo Stopping Microsoft SQL Server
echo ==========================================

docker compose down

if errorlevel 1 (
    echo.
    echo Failed to stop SQL Server!
    exit /b 1
)

echo.
echo SQL Server stopped successfully!
echo.
echo Note: Data is preserved in Docker volumes.
echo To remove volumes: docker compose down -v
