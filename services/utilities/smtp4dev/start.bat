@echo off
REM Start SMTP4Dev

echo ==========================================
echo Starting SMTP4Dev
echo ==========================================

REM Check if .env exists
if not exist .env (
    echo No .env file found. Creating from template...
    copy .env.template .env
)

REM Start service
docker compose up -d

if errorlevel 1 (
    echo.
    echo Failed to start SMTP4Dev!
    exit /b 1
)

echo.
echo SMTP4Dev started successfully!
echo.
echo Access points:
echo   Web UI:  http://localhost:7777
echo   SMTP:    localhost:25
echo   IMAP:    localhost:143
echo   POP3:    localhost:110
echo.
echo Send test emails to SMTP port 25 and view them in the web UI.
echo.
echo Check status: docker compose ps
echo View logs:    docker compose logs -f
echo Stop service: stop.bat
