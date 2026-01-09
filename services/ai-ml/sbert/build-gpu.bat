@echo off
REM Build SBERT GPU (CUDA) image

echo Building SBERT (GPU/CUDA)...
docker compose build sbert-gpu

echo.
echo SBERT GPU image built successfully
echo   Image: local/sbert:cuda
echo.
echo To start: start-gpu.bat
