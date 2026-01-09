@echo off
REM Stop OpenSearch

echo ==========================================
echo Stopping OpenSearch
echo ==========================================

docker compose down

if errorlevel 1 (
    echo.
    echo Failed to stop OpenSearch!
    exit /b 1
)

echo.
echo OpenSearch stopped successfully!
echo.
echo Note: Data is preserved in Docker volumes.
echo To remove volumes: docker compose down -v
