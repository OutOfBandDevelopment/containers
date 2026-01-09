@echo off
REM Start LocalStack

echo ==========================================
echo Starting LocalStack (AWS Emulator)
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
    echo Failed to start LocalStack!
    exit /b 1
)

echo.
echo LocalStack is starting (this may take 20-30 seconds)...
timeout /t 20 /nobreak >nul

echo.
echo LocalStack started successfully!
echo.
echo API Endpoint: http://localhost:4566
echo.
echo Test with AWS CLI:
echo   aws --endpoint-url=http://localhost:4566 s3 ls
echo.
echo Health check:
echo   curl http://localhost:4566/_localstack/health
echo.
echo Check status: docker compose ps
echo View logs:    docker compose logs -f
echo Stop service: stop.bat
