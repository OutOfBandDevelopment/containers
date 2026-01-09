@echo off
REM Start Open WebUI

echo ==========================================
echo Starting Open WebUI
echo ==========================================

REM Check if .env exists
if not exist .env (
    echo No .env file found. Creating from template...
    copy .env.template .env
)

echo NOTE: This service requires Ollama to be running.
echo       Make sure Ollama is accessible at the configured URL.
echo.

REM Start service
docker compose up -d

if errorlevel 1 (
    echo.
    echo Failed to start Open WebUI!
    exit /b 1
)

echo.
echo Open WebUI is starting (this may take 10-15 seconds)...
timeout /t 10 /nobreak >nul

echo.
echo Open WebUI started successfully!
echo.
echo Access point:
echo   Web UI: http://localhost:3000
echo.
echo First time? Create an admin account (first user is admin)
echo.
echo Check status: docker compose ps
echo View logs:    docker compose logs -f
echo Stop service: stop.bat
