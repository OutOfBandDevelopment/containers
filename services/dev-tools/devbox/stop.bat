@echo off
REM Stop DevBox

echo ==========================================
echo Stopping DevBox
echo ==========================================

REM DevBox runs with --rm flag, so containers are automatically removed on exit
REM This script stops any running instances

docker compose down

if errorlevel 1 (
    echo.
    echo Failed to stop DevBox!
    exit /b 1
)

echo.
echo DevBox stopped successfully!
echo.
echo Note: Project files and package caches are preserved in Docker volumes.
echo To remove volumes: docker compose down -v
