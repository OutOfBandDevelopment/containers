@echo off
REM Stop OpenSearch Dashboards

echo ==========================================
echo Stopping OpenSearch Dashboards
echo ==========================================

docker compose down

if errorlevel 1 (
    echo.
    echo Failed to stop OpenSearch Dashboards!
    exit /b 1
)

echo.
echo OpenSearch Dashboards stopped successfully!
