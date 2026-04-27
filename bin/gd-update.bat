@echo off
setlocal enabledelayedexpansion

:: ============================================
:: gd-update - Godot Version Manager
:: ============================================

set "COMMAND=%~1"
set "VERSION=%~2"

if "%COMMAND%"=="" set "COMMAND=list"

where godotenv >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo   [ERROR] GodotEnv not found!
    echo   Run 'gd-setup' first to install GodotEnv.
    echo.
    exit /b 1
)

echo.
echo   ====================================
echo   gd-update - Godot Version Manager
echo   ====================================
echo.

if /i "%COMMAND%"=="list" (
    echo   Installed Godot versions:
    echo   -------------------------
    godotenv godot list
    echo.
    exit /b 0
)

if /i "%COMMAND%"=="remote" (
    echo   Available Godot versions:
    echo   -------------------------
    godotenv godot list -r
    echo.
    exit /b 0
)

if /i "%COMMAND%"=="install" (
    if "%VERSION%"=="" (
        echo   [ERROR] Version required
        echo   Usage: gd-update install [version]
        echo   Example: gd-update install 4.5-stable
        echo.
        echo   Run 'gd-update remote' to see available versions
        exit /b 1
    )
    echo   [*] Installing Godot %VERSION%...
    godotenv godot install %VERSION%
    exit /b %errorlevel%
)

if /i "%COMMAND%"=="use" (
    if "%VERSION%"=="" (
        echo   [ERROR] Version required
        echo   Usage: gd-update use [version]
        exit /b 1
    )
    echo   [*] Switching to Godot %VERSION%...
    godotenv godot use %VERSION%
    exit /b %errorlevel%
)

if /i "%COMMAND%"=="remove" (
    if "%VERSION%"=="" (
        echo   [ERROR] Version required
        echo   Usage: gd-update remove [version]
        exit /b 1
    )
    echo   [*] Removing Godot %VERSION%...
    godotenv godot uninstall %VERSION%
    exit /b %errorlevel%
)

if /i "%COMMAND%"=="latest" (
    echo   [*] Installing latest Godot version...
    godotenv godot install
    exit /b %errorlevel%
)

echo   Unknown command: %COMMAND%
echo.
echo   Available commands:
echo     list          Show installed versions
echo     remote        Show available versions
echo     install VER   Install specific version
echo     use VER       Switch to version
echo     remove VER    Remove version
echo     latest        Install latest version
echo.

exit /b 1
