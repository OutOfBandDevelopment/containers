@echo off
REM Start Qdrant Vector Database

echo ==========================================
echo Starting Qdrant Vector Database
echo ==========================================

REM Check if .env exists
if not exist .env (
    echo No .env file found. Creating from template...
    copy .env.template .env
    echo Please edit .env with your settings and run again.
    exit /b 1
)

REM Start service
docker compose up -d

if errorlevel 1 (
    echo.
    echo Failed to start Qdrant!
    exit /b 1
)

echo.
echo Qdrant started successfully!
echo.
echo Access points:
echo   REST API:  http://localhost:6333
echo   gRPC API:  localhost:6334
echo   Dashboard: http://localhost:6333/dashboard
echo.
echo Check status: docker compose ps
echo View logs:    docker compose logs -f
echo Stop service: stop.bat
