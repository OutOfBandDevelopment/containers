@echo off
REM Start ParadeDB

echo ==========================================
echo Starting ParadeDB
echo ==========================================

REM Check if .env exists
if not exist .env (
    echo No .env file found. Creating from template...
    copy .env.template .env
    echo IMPORTANT: Edit .env and change passwords!
    echo Then run this script again.
    exit /b 1
)

REM Start service
docker compose up -d

if errorlevel 1 (
    echo.
    echo Failed to start ParadeDB!
    exit /b 1
)

echo.
echo ParadeDB is starting (this may take 10-20 seconds)...
timeout /t 10 /nobreak >nul

echo.
echo ParadeDB started successfully!
echo.
echo Connection details:
echo   Host:     localhost
echo   Port:     5432
echo   Database: paradedb
echo   Username: admin
echo   Password: (check your .env file)
echo.
echo Connect with psql:
echo   docker exec -it paradedb psql -U admin -d paradedb
echo.
echo Check status: docker compose ps
echo View logs:    docker compose logs -f
echo Stop service: stop.bat
