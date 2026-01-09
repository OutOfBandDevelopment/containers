@echo off
REM Start MongoDB

echo ==========================================
echo Starting MongoDB
echo ==========================================

REM Check if .env exists
if not exist .env (
    echo No .env file found. Creating from template...
    copy .env.template .env
    echo IMPORTANT: Edit .env and change credentials!
    echo Then run this script again.
    exit /b 1
)

REM Start service
docker compose up -d

if errorlevel 1 (
    echo.
    echo Failed to start MongoDB!
    exit /b 1
)

echo.
echo MongoDB is starting (this may take 10-15 seconds)...
timeout /t 10 /nobreak >nul

echo.
echo MongoDB started successfully!
echo.
echo Connection details:
echo   Host:     localhost
echo   Port:     27017
echo   Username: admin
echo   Password: (check your .env file)
echo.
echo Connect with mongosh:
echo   docker exec -it mongodb mongosh -u admin -p "YourPassword"
echo.
echo MongoDB Compass:
echo   mongodb://admin:YourPassword@localhost:27017
echo.
echo Check status: docker compose ps
echo View logs:    docker compose logs -f
echo Stop service: stop.bat
