@echo off
REM Build SBERT CPU image

echo Building SBERT (CPU)...
docker compose build sbert-cpu

echo.
echo SBERT CPU image built successfully
echo   Image: local/sbert:cpu
echo.
echo To start: start-cpu.bat
