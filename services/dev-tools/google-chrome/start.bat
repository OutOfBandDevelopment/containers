@echo off
echo ==========================================
echo Starting Google Chrome
echo ==========================================
if not exist .env copy .env.template .env
docker images | findstr /C:"outofbanddevelopment/google-chrome" >nul
if errorlevel 1 (call build.bat && if errorlevel 1 exit /b 1)
echo NOTE: Requires WSLg (Windows WSL2)
docker compose up -d
if errorlevel 1 exit /b 1
echo.
echo Chrome started! Window should appear.
echo Remote debugging: http://localhost:9223
