@echo off
echo ==========================================
echo Building Wine Image
echo ==========================================
if not exist .env copy .env.template .env
echo Building (this may take 5-10 minutes)...
docker compose build
if errorlevel 1 exit /b 1
echo.
echo Wine image built successfully!
