@echo off
echo ==========================================
echo Starting PlantUML Server
echo ==========================================
if not exist .env (
    copy .env.template .env
    echo Created .env from template
)
docker compose up -d
echo.
echo PlantUML Server started successfully!
echo.
echo Access PlantUML: http://localhost:8080
echo.
echo Stop service: stop.bat
