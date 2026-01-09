@echo off
REM Start Apache Kafka

echo ==========================================
echo Starting Apache Kafka (KRaft mode)
echo ==========================================

REM Check if .env exists
if not exist .env (
    echo No .env file found. Creating from template...
    copy .env.template .env
)

REM Start service
docker compose up -d

if errorlevel 1 (
    echo.
    echo Failed to start Kafka!
    exit /b 1
)

echo.
echo Kafka is starting (this may take 20-30 seconds)...
timeout /t 20 /nobreak >nul

echo.
echo Kafka started successfully!
echo.
echo Connection details:
echo   Internal: localhost:9092
echo   External: localhost:9094
echo.
echo Create a topic:
echo   docker exec kafka kafka-topics.sh --create --bootstrap-server localhost:9092 --topic my-topic
echo.
echo List topics:
echo   docker exec kafka kafka-topics.sh --list --bootstrap-server localhost:9092
echo.
echo Check status: docker compose ps
echo View logs:    docker compose logs -f
echo Stop service: stop.bat
