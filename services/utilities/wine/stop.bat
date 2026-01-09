@echo off
echo ==========================================
echo Stopping Wine
echo ==========================================
docker compose down
if errorlevel 1 exit /b 1
echo.
echo Wine stopped. Wine prefix preserved in volumes.
