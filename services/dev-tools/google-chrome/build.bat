@echo off
echo ==========================================
echo Building Google Chrome Image
echo ==========================================
if not exist .env copy .env.template .env
docker compose build
if errorlevel 1 exit /b 1
echo.
echo Google Chrome image built successfully!
echo Next steps: start.bat
