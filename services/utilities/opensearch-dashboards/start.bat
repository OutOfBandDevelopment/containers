@echo off
REM Start OpenSearch Dashboards

echo ==========================================
echo Starting OpenSearch Dashboards
echo ==========================================

REM Check if .env exists
if not exist .env (
    echo No .env file found. Creating from template...
    copy .env.template .env
)

echo NOTE: This service requires OpenSearch to be running.
echo       Make sure OpenSearch is accessible at the configured host.
echo.

REM Start service
docker compose up -d

if errorlevel 1 (
    echo.
    echo Failed to start OpenSearch Dashboards!
    exit /b 1
)

echo.
echo OpenSearch Dashboards is starting (this may take 10-15 seconds)...
timeout /t 10 /nobreak >nul

echo.
echo OpenSearch Dashboards started successfully!
echo.
echo Access point:
echo   Web UI: http://localhost:5601
echo.
echo Check status: docker compose ps
echo View logs:    docker compose logs -f
echo Stop service: stop.bat
