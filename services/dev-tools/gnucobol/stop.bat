@echo off
REM Stop GNU COBOL

echo ==========================================
echo Stopping GNU COBOL
echo ==========================================

docker compose down

if errorlevel 1 (
    echo.
    echo Failed to stop GNU COBOL!
    exit /b 1
)

echo.
echo GNU COBOL stopped successfully!
echo.
echo Note: COBOL source files are preserved in Docker volumes.
echo To remove volumes: docker compose down -v
