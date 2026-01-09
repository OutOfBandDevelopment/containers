@echo off
echo ==========================================
echo Starting Wine
echo ==========================================
if not exist .env copy .env.template .env
docker images | findstr /C:"outofbanddevelopment/wine" >nul
if errorlevel 1 (call build.bat && if errorlevel 1 exit /b 1)
echo NOTE: Requires WSLg (WSL2)
docker compose run --rm wine
