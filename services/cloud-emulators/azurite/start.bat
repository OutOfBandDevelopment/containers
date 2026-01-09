@echo off
REM Start Azurite

echo ==========================================
echo Starting Azurite (Azure Storage Emulator)
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
    echo Failed to start Azurite!
    exit /b 1
)

echo.
echo Azurite started successfully!
echo.
echo Services:
echo   Blob:  http://localhost:10000
echo   Queue: http://localhost:10001
echo   Table: http://localhost:10002
echo.
echo Default Account:
echo   Name: devstoreaccount1
echo   Key:  Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==
echo.
echo Check status: docker compose ps
echo View logs:    docker compose logs -f
echo Stop service: stop.bat
