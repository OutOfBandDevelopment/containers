@echo off
REM Build GNU COBOL custom image

echo ==========================================
echo Building GNU COBOL Image
echo ==========================================

if not exist .env (
    copy .env.template .env
    echo Using default configuration.
)

docker compose build

if errorlevel 1 (
    echo.
    echo Failed to build GNU COBOL image!
    exit /b 1
)

echo.
echo GNU COBOL image built successfully!
echo.
echo Image: outofbanddevelopment/gnucobol:latest
echo.
echo Next steps:
echo   Start shell: start.bat
