@echo off
REM Build DevBox custom image

echo ==========================================
echo Building DevBox Image
echo ==========================================

REM Check if .env exists
if not exist .env (
    echo No .env file found. Creating from template...
    copy .env.template .env
    echo Using default configuration.
)

REM Build the custom image
echo.
echo Building image (this may take 5-10 minutes)...
docker compose build

if errorlevel 1 (
    echo.
    echo Failed to build DevBox image!
    exit /b 1
)

echo.
echo DevBox image built successfully!
echo.
echo Image: outofbanddevelopment/devbox:latest
echo.
echo Installed tools:
echo   - Node.js (LTS)
echo   - .NET 9.0 SDK
echo   - Java 21
echo   - Go (configurable)
echo   - Rust
echo   - PlatformIO
echo   - Claude Code CLI
echo.
echo Next steps:
echo   Start shell: start.bat
echo   Check image: docker images ^| findstr devbox
