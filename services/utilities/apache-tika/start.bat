@echo off
REM Start Apache Tika

echo ==========================================
echo Starting Apache Tika
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
    echo Failed to start Apache Tika!
    exit /b 1
)

echo.
echo Apache Tika started successfully!
echo.
echo Access point:
echo   REST API: http://localhost:9998
echo.
echo Test with:
echo   curl http://localhost:9998/tika
echo.
echo Check status: docker compose ps
echo View logs:    docker compose logs -f
echo Stop service: stop.bat
