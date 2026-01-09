@echo off
REM Stop ComfyUI

echo ==========================================
echo Stopping ComfyUI
echo ==========================================

docker compose down

if errorlevel 1 (
    echo.
    echo Failed to stop ComfyUI!
    exit /b 1
)

echo.
echo ComfyUI stopped successfully!
echo.
echo Note: Models and generated images are preserved in Docker volumes.
echo To remove volumes: docker compose down -v
