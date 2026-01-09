@echo off
REM Start SBERT (GPU/CUDA)

echo Starting SBERT (GPU/CUDA)...
docker compose --profile gpu up -d

echo.
echo SBERT GPU started
echo   URL: http://localhost:8080
echo.
echo To stop: stop.bat
