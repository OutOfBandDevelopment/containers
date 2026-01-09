@echo off
REM Start ComfyUI

echo ==========================================
echo Starting ComfyUI
echo ==========================================

REM Check if .env exists
if not exist .env (
    echo No .env file found. Creating from template...
    copy .env.template .env
)

REM Check for NVIDIA GPU
nvidia-smi >nul 2>&1
if errorlevel 1 (
    echo WARNING: nvidia-smi not found. ComfyUI requires NVIDIA GPU and drivers.
    echo Continuing anyway, but service may not work correctly.
)

REM Start service
docker compose up -d

if errorlevel 1 (
    echo.
    echo Failed to start ComfyUI!
    exit /b 1
)

echo.
echo ComfyUI is starting (this may take 30-60 seconds)...
timeout /t 30 /nobreak >nul

echo.
echo ComfyUI started successfully!
echo.
echo Access ComfyUI: http://localhost:8188
echo.
echo IMPORTANT: Add Stable Diffusion models to comfyui-models volume
echo   docker cp model.safetensors comfyui:/root/ComfyUI/models/checkpoints/
echo.
echo Check status: docker compose ps
echo View logs:    docker compose logs -f
echo Stop service: stop.bat
