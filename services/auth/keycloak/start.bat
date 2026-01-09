@echo off
REM Start Keycloak

echo ==========================================
echo Starting Keycloak
echo ==========================================

REM Check if .env exists
if not exist .env (
    echo No .env file found. Creating from template...
    copy .env.template .env
    echo IMPORTANT: Edit .env and change KEYCLOAK_ADMIN_PASSWORD!
    echo Then run this script again.
    exit /b 1
)

REM Start service
docker compose up -d

if errorlevel 1 (
    echo.
    echo Failed to start Keycloak!
    exit /b 1
)

echo.
echo Keycloak is starting (this may take 30-60 seconds)...
timeout /t 30 /nobreak >nul

echo.
echo Keycloak started successfully!
echo.
echo Access points:
echo   Admin Console: http://localhost:8081
echo   Realm:         local-dev
echo   Username:      admin
echo   Password:      (check your .env file)
echo.
echo Check status: docker compose ps
echo View logs:    docker compose logs -f
echo Stop service: stop.bat
