@echo off
REM Start Jupyter Lab

echo ==========================================
echo Starting Jupyter Lab
echo ==========================================

REM Check if .env exists
if not exist .env (
    echo No .env file found. Creating from template...
    copy .env.template .env
)

REM Check if image exists
docker images | findstr /C:"outofbanddevelopment/jupyter" >nul
if errorlevel 1 (
    echo Jupyter Lab image not found. Building...
    call build.bat
    if errorlevel 1 exit /b 1
)

REM Start service
docker compose up -d

if errorlevel 1 (
    echo.
    echo Failed to start Jupyter Lab!
    exit /b 1
)

echo.
echo Jupyter Lab is starting (this may take 10-15 seconds)...
timeout /t 10 /nobreak >nul

echo.
echo Jupyter Lab started successfully!
echo.
echo Access Jupyter Lab: http://localhost:8888
echo.
echo Available kernels:
echo   - Python 3 (with PyTorch, TensorFlow)
echo   - .NET (C#)
echo   - Java
echo   - Go
echo   - Ruby
echo   - TypeScript/JavaScript
echo.
echo Check status: docker compose ps
echo View logs:    docker compose logs -f
echo Stop service: stop.bat
