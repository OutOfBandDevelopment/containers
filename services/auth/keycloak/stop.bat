@echo off
REM Stop Keycloak

echo ==========================================
echo Stopping Keycloak
echo ==========================================

docker compose down

if errorlevel 1 (
    echo.
    echo Failed to stop Keycloak!
    exit /b 1
)

echo.
echo Keycloak stopped successfully!
echo.
echo Note: Data is preserved in Docker volumes.
echo To remove volumes: docker compose down -v
