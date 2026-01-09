@echo off
cd /d "%~dp0\.."

echo ==========================================
echo Deploying AI Workspace (Docker Compose)
echo ==========================================

if not exist .env (
    echo Creating .env from template...
    copy .env.template .env
    echo.
    echo IMPORTANT: Edit .env and configure your settings!
    echo Especially change SEARXNG_SECRET before deploying.
    echo.
    exit /b 1
)

echo Starting services...
docker compose up -d

echo.
echo Waiting for services to be ready...
timeout /t 5 /nobreak >nul

echo.
echo ==========================================
echo AI Workspace Status
echo ==========================================
docker compose ps

echo.
echo ==========================================
echo Access Points
echo ==========================================
echo Open WebUI:         http://localhost/
echo Ollama API:         http://localhost/ollama/
echo SearXNG:            http://localhost/searxng/
echo Apache Tika:        http://localhost/tika/
echo Health Check:       http://localhost/health
echo.
echo Stop services: scripts\stop-compose.bat
echo ==========================================
