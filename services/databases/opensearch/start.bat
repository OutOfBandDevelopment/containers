@echo off
REM Start OpenSearch

echo ==========================================
echo Starting OpenSearch
echo ==========================================

REM Check if .env exists
if not exist .env (
    echo No .env file found. Creating from template...
    copy .env.template .env
    echo IMPORTANT: Edit .env and change OPENSEARCH_ADMIN_PASSWORD!
    echo Then run this script again.
    exit /b 1
)

echo NOTE: Ensure vm.max_map_count is set to 262144 or higher
echo For WSL2: wsl -d docker-desktop sysctl -w vm.max_map_count=262144
echo.

REM Start service
docker compose up -d

if errorlevel 1 (
    echo.
    echo Failed to start OpenSearch!
    exit /b 1
)

echo.
echo OpenSearch started successfully!
echo.
echo Access points:
echo   REST API:  http://localhost:9200
echo   Username:  admin
echo   Password:  (check your .env file)
echo.
echo Check status: docker compose ps
echo View logs:    docker compose logs -f
echo Stop service: stop.bat
