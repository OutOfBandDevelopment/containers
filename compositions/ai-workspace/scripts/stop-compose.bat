@echo off
cd /d "%~dp0\.."

echo Stopping AI Workspace services...
docker compose down

echo AI Workspace stopped. Data preserved in volumes.
