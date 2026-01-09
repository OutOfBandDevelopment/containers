@echo off
echo ==========================================
echo Stopping Google Chrome
echo ==========================================
docker compose down
if errorlevel 1 exit /b 1
echo.
echo Chrome stopped. Profile data preserved in volumes.
