@echo off
REM Start DevBox interactive shell

echo ==========================================
echo Starting DevBox
echo ==========================================

REM Check if .env exists
if not exist .env (
    echo No .env file found. Creating from template...
    copy .env.template .env
)

REM Check if image exists
docker images | findstr /C:"outofbanddevelopment/devbox" >nul
if errorlevel 1 (
    echo DevBox image not found. Building...
    call build.bat
    if errorlevel 1 exit /b 1
)

echo.
echo Starting interactive bash shell...
echo All development tools are available:
echo   - node, npm, npx
echo   - dotnet
echo   - java, javac
echo   - go
echo   - rustc, cargo
echo   - pio (PlatformIO)
echo   - claude (Claude Code CLI)
echo.
echo Type 'exit' to stop the container.
echo.

REM Start interactive shell
docker compose run --rm devbox
