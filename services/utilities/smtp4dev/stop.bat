@echo off
REM Stop SMTP4Dev

echo ==========================================
echo Stopping SMTP4Dev
echo ==========================================

docker compose down

if errorlevel 1 (
    echo.
    echo Failed to stop SMTP4Dev!
    exit /b 1
)

echo.
echo SMTP4Dev stopped successfully!
echo.
echo Note: Emails are preserved in Docker volumes.
echo To remove volumes: docker compose down -v
