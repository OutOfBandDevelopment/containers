@echo off
REM Build Keycloak

echo ==========================================
echo Building Keycloak
echo ==========================================

docker compose build

if errorlevel 1 (
    echo.
    echo Build failed!
    exit /b 1
)

echo.
echo Build complete!
echo.
echo Start service: start.bat
