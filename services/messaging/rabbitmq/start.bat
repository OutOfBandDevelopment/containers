@echo off
REM Start RabbitMQ

echo ==========================================
echo Starting RabbitMQ
echo ==========================================

REM Check if .env exists
if not exist .env (
    echo No .env file found. Creating from template...
    copy .env.template .env
    echo IMPORTANT: Edit .env and change RABBITMQ_USER and RABBITMQ_PASSWORD!
    echo Then run this script again.
    exit /b 1
)

REM Start service
docker compose up -d

if errorlevel 1 (
    echo.
    echo Failed to start RabbitMQ!
    exit /b 1
)

echo.
echo RabbitMQ is starting (this may take 15-20 seconds)...
timeout /t 15 /nobreak >nul

echo.
echo RabbitMQ started successfully!
echo.
echo Access points:
echo   AMQP:         amqp://localhost:5672
echo   Management:   http://localhost:15672
echo   Username:     (check your .env file)
echo   Password:     (check your .env file)
echo.
echo Check status: docker compose ps
echo View logs:    docker compose logs -f
echo Stop service: stop.bat
