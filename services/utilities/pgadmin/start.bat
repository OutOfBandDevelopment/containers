@echo off
REM Start pgAdmin

echo ==========================================
echo Starting pgAdmin
echo ==========================================

REM Check if .env exists
if not exist .env (
    echo No .env file found. Creating from template...
    copy .env.template .env
    echo IMPORTANT: Edit .env and change PGADMIN_EMAIL and PGADMIN_PASSWORD!
    echo Then run this script again.
    exit /b 1
)

REM Start service
docker compose up -d

if errorlevel 1 (
    echo.
    echo Failed to start pgAdmin!
    exit /b 1
)

echo.
echo pgAdmin is starting (this may take 5-10 seconds)...
timeout /t 5 /nobreak >nul

echo.
echo pgAdmin started successfully!
echo.
echo Access point:
echo   Web UI: http://localhost:8082
echo   Email:  (check your .env file)
echo   Password: (check your .env file)
echo.
echo Check status: docker compose ps
echo View logs:    docker compose logs -f
echo Stop service: stop.bat
