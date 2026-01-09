@echo off
REM Start GNU COBOL interactive shell

echo ==========================================
echo Starting GNU COBOL
echo ==========================================

if not exist .env (
    copy .env.template .env
)

docker images | findstr /C:"outofbanddevelopment/gnucobol" >nul
if errorlevel 1 (
    echo GNU COBOL image not found. Building...
    call build.bat
    if errorlevel 1 exit /b 1
)

echo.
echo Starting interactive bash shell...
echo COBOL compiler available: cobc, cobcrun
echo.
echo Type 'exit' to stop the container.
echo.

docker compose run --rm gnucobol
