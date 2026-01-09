@echo off
REM Stop Apache Tika

echo ==========================================
echo Stopping Apache Tika
echo ==========================================

docker compose down

if errorlevel 1 (
    echo.
    echo Failed to stop Apache Tika!
    exit /b 1
)

echo.
echo Apache Tika stopped successfully!
