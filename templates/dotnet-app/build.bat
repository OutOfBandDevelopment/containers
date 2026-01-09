@echo off
REM Generic .NET Docker build script
REM Usage: build.bat <project-name> <dll-name> [dotnet-version] [image-tag]

setlocal

REM Parameters (with defaults)
set PROJECT_NAME=%1
set DLL_NAME=%2
set DOTNET_VERSION=%3
set IMAGE_TAG=%4

REM Set defaults if not provided
if "%PROJECT_NAME%"=="" set PROJECT_NAME=MyApp.WebApi
if "%DLL_NAME%"=="" set DLL_NAME=%PROJECT_NAME%
if "%DOTNET_VERSION%"=="" set DOTNET_VERSION=8.0
if "%IMAGE_TAG%"=="" (
    set IMAGE_TAG=%PROJECT_NAME%:latest
    set IMAGE_TAG=!IMAGE_TAG: =!
    for %%i in ("!IMAGE_TAG!") do set IMAGE_TAG=%%~nxi
    call :lowercase IMAGE_TAG
)

echo ==========================================
echo Building .NET Docker Image
echo ==========================================
echo Project Name:    %PROJECT_NAME%
echo DLL Name:        %DLL_NAME%
echo .NET Version:    %DOTNET_VERSION%
echo Image Tag:       %IMAGE_TAG%
echo ==========================================

REM Build the image
docker build ^
    --build-arg DOTNET_VERSION=%DOTNET_VERSION% ^
    --build-arg PROJECT_NAME=%PROJECT_NAME% ^
    --build-arg DLL_NAME=%DLL_NAME% ^
    -t %IMAGE_TAG% ^
    -f Dockerfile ^
    .

if errorlevel 1 (
    echo.
    echo Build failed!
    exit /b 1
)

echo.
echo Build complete!
echo   Image: %IMAGE_TAG%
echo.
echo To run:
echo   docker run -p 8080:80 %IMAGE_TAG%

endlocal
exit /b 0

:lowercase
REM Helper to convert to lowercase
for %%L in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do (
    call set %1=%%%1:%%L=%%L%%
)
exit /b
