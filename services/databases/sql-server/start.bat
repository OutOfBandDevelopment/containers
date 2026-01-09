@echo off
REM Start Microsoft SQL Server

echo ==========================================
echo Starting Microsoft SQL Server
echo ==========================================

REM Check if .env exists
if not exist .env (
    echo No .env file found. Creating from template...
    copy .env.template .env
    echo IMPORTANT: Edit .env and change MSSQL_SA_PASSWORD!
    echo Password must be at least 8 characters with uppercase, lowercase, digits, and symbols.
    echo Then run this script again.
    exit /b 1
)

REM Start service
docker compose up -d

if errorlevel 1 (
    echo.
    echo Failed to start SQL Server!
    exit /b 1
)

echo.
echo SQL Server is starting (this may take 30-60 seconds)...
echo.
echo Please wait while SQL Server initializes...
timeout /t 15 /nobreak >nul

echo.
echo SQL Server started!
echo.
echo Connection details:
echo   Server:   localhost,1433
echo   Username: sa
echo   Password: (check your .env file)
echo.
echo Connect with sqlcmd:
echo   docker exec -it sql-server /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "YourPassword"
echo.
echo Check status: docker compose ps
echo View logs:    docker compose logs -f
echo Stop service: stop.bat
