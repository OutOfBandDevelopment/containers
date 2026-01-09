@echo off
REM Start SBERT (CPU)

echo Starting SBERT (CPU)...
docker compose --profile cpu up -d

echo.
echo SBERT CPU started
echo   URL: http://localhost:8080
echo.
echo To stop: stop.bat
