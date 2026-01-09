@echo off
echo ==========================================
echo Starting TensorFlow Jupyter Lab
echo ==========================================
if not exist .env copy .env.template .env
docker images | findstr /C:"outofbanddevelopment/tensorflow-jupyterlab" >nul
if errorlevel 1 (call build.bat && if errorlevel 1 exit /b 1)
docker compose up -d
if errorlevel 1 exit /b 1
echo.
echo TensorFlow Jupyter Lab is starting...
timeout /t 10 /nobreak >nul
echo.
echo Access Jupyter Lab: http://localhost:8889
echo Stop service: stop.bat
