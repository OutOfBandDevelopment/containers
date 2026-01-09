@echo off
REM Build Jupyter Lab custom image

echo ==========================================
echo Building Jupyter Lab Image
echo ==========================================

REM Check if .env exists
if not exist .env (
    echo No .env file found. Creating from template...
    copy .env.template .env
    echo Using default configuration.
)

REM Build the custom image
docker compose build

if errorlevel 1 (
    echo.
    echo Failed to build Jupyter Lab image!
    exit /b 1
)

echo.
echo Jupyter Lab image built successfully!
echo.
echo Image: outofbanddevelopment/jupyter:latest
echo.
echo Next steps:
echo   Start service: start.bat
echo   Check images:  docker images ^| findstr jupyter
