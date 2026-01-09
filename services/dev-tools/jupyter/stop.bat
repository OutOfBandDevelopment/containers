@echo off
REM Stop Jupyter Lab

echo ==========================================
echo Stopping Jupyter Lab
echo ==========================================

docker compose down

if errorlevel 1 (
    echo.
    echo Failed to stop Jupyter Lab!
    exit /b 1
)

echo.
echo Jupyter Lab stopped successfully!
echo.
echo Note: Notebooks and workspace are preserved in Docker volumes.
echo To remove volumes: docker compose down -v
