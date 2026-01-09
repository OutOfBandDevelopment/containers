@echo off
echo ==========================================
echo Stopping TensorFlow Jupyter Lab
echo ==========================================
docker compose down
if errorlevel 1 exit /b 1
echo.
echo TensorFlow Jupyter Lab stopped successfully!
echo Note: Notebooks and models are preserved in Docker volumes.
echo To remove volumes: docker compose down -v
