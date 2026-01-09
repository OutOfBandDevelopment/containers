@echo off
REM Stop SBERT

echo Stopping SBERT...
docker compose --profile cpu --profile gpu down

echo.
echo SBERT stopped
