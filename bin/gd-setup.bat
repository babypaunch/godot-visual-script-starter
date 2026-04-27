@echo off
setlocal enabledelayedexpansion

:: ============================================
:: gd-setup - Godot Environment Setup
:: ============================================

echo.
echo   ====================================
echo   gd-setup - Godot Environment Setup
echo   ====================================
echo.

where dotnet >nul 2>&1
if %errorlevel% neq 0 (
    echo   [ERROR] .NET SDK not found!
    echo   Please install from: https://dotnet.microsoft.com/download
    echo.
    exit /b 1
)
echo   [OK] .NET SDK found

where godotenv >nul 2>&1
if %errorlevel% neq 0 (
    echo   [*] Installing GodotEnv...
    dotnet tool install --global Chickensoft.GodotEnv
    if !errorlevel! neq 0 (
        echo   [ERROR] Failed to install GodotEnv
        echo   [!] You may need .NET 8.0 SDK
        exit /b 1
    )
    echo   [OK] GodotEnv installed
) else (
    echo   [OK] GodotEnv already installed
    echo   [*] Checking for updates...
    dotnet tool update --global Chickensoft.GodotEnv >nul 2>&1
)

echo.
echo   [*] Checking Godot installation...

set "GODOT_VERSION=4.5-stable"
godotenv godot list 2>nul | findstr /C:"4.5" >nul
if %errorlevel% neq 0 (
    echo   [*] Installing Godot 4.5...
    godotenv godot install %GODOT_VERSION%
    if !errorlevel! neq 0 (
        echo   [ERROR] Failed to install Godot
        exit /b 1
    )
    echo   [OK] Godot 4.5 installed
) else (
    echo   [OK] Godot 4.5 already installed
)

echo   [*] Setting Godot 4.5 as default...
godotenv godot use %GODOT_VERSION% >nul 2>&1

echo.
echo   ====================================
echo   Setup Complete!
echo   ====================================
echo.
echo   Installed:
echo     - GodotEnv (global tool)
echo     - Godot 4.5
echo.
echo   Commands available:
echo     gd-init [name]    Create new Godot project
echo     gd-init --here    Initialize in current folder
echo     gd-update         Update Godot version
echo     gd-addon          Manage addons
echo.

exit /b 0
