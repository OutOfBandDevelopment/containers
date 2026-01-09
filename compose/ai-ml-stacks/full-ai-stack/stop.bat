SETLOCAL
IF "%APP_PROJECT%"=="" SET APP_PROJECT=container-store

docker compose --project-name %APP_PROJECT% stop
ENDLOCAL