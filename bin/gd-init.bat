@echo off
setlocal enabledelayedexpansion

:: ============================================
:: gd-init - Godot Project Initializer
:: ============================================

set "PROJECT_NAME="
set "INIT_HERE=false"
set "FORCE_MODE=false"
set "NO_ADDON=false"
set "SHOW_HELP=false"

:parse_args
if "%~1"=="" goto :done_parsing
if /i "%~1"=="--help" set "SHOW_HELP=true" & shift & goto :parse_args
if /i "%~1"=="--here" set "INIT_HERE=true" & shift & goto :parse_args
if /i "%~1"=="-h" set "INIT_HERE=true" & shift & goto :parse_args
if /i "%~1"=="--force" set "FORCE_MODE=true" & shift & goto :parse_args
if /i "%~1"=="-f" set "FORCE_MODE=true" & shift & goto :parse_args
if /i "%~1"=="--no-addon" set "NO_ADDON=true" & shift & goto :parse_args
if not defined PROJECT_NAME set "PROJECT_NAME=%~1"
shift
goto :parse_args

:done_parsing

if "%SHOW_HELP%"=="true" (
    echo.
    echo   gd-init - Godot Project Initializer
    echo   ====================================
    echo.
    echo   Usage: gd-init [project-name] [options]
    echo.
    echo   Options:
    echo     --here, -h     Initialize in current folder
    echo     --force, -f    Overwrite existing files
    echo     --no-addon     Skip Orchestrator installation
    echo     --help         Show this help
    echo.
    echo   Examples:
    echo     gd-init my-game           Create new project
    echo     gd-init --here            Initialize in current folder
    echo     gd-init my-game --force   Overwrite if exists
    echo.
    exit /b 0
)

if "%INIT_HERE%"=="true" (
    for %%I in (.) do set "PROJECT_NAME=%%~nxI"
    set "PROJECT_PATH=%CD%"
    goto :start_init
)

if not defined PROJECT_NAME (
    echo.
    echo   [ERROR] Project name required
    echo   Usage: gd-init [project-name] or gd-init --here
    echo.
    exit /b 1
)

set "PROJECT_PATH=%CD%\%PROJECT_NAME%"

:start_init
echo.
echo   ====================================
echo   gd-init - Godot Project Initializer
echo   ====================================
echo.
echo   Project: %PROJECT_NAME%
echo   Path: %PROJECT_PATH%
echo.

if exist "%PROJECT_PATH%" (
    if "%INIT_HERE%"=="false" (
        if "%FORCE_MODE%"=="false" (
            echo   [!] Folder already exists: %PROJECT_PATH%
            echo.
            set /p "CONFIRM=   Merge into existing folder? (y/N): "
            if /i not "!CONFIRM!"=="y" (
                echo   Cancelled.
                exit /b 0
            )
        ) else (
            echo   [*] Force mode: merging into existing folder
        )
    )
    echo   [*] Initializing in existing folder...
) else (
    echo   [*] Creating new folder...
    mkdir "%PROJECT_PATH%"
)

cd /d "%PROJECT_PATH%"

if not exist "project.godot" (
    echo   [+] Creating project.godot...
    call :create_project_godot
) else (
    if "%FORCE_MODE%"=="true" (
        echo   [!] Overwriting project.godot...
        call :create_project_godot
    ) else (
        echo   [=] project.godot exists, skipping...
    )
)

echo   [+] Creating folder structure...
if not exist "scenes" mkdir "scenes"
if not exist "scripts" mkdir "scripts"
if not exist "assets" mkdir "assets"
if not exist "assets\sprites" mkdir "assets\sprites"
if not exist "assets\audio" mkdir "assets\audio"
if not exist "assets\fonts" mkdir "assets\fonts"
if not exist "assets\models" mkdir "assets\models"
if not exist "addons" mkdir "addons"

if not exist ".gitignore" (
    echo   [+] Creating .gitignore...
    call :create_gitignore
) else (
    echo   [=] .gitignore exists, skipping...
)

if not exist "scenes\main.tscn" (
    echo   [+] Creating main scene...
    call :create_main_scene
) else (
    echo   [=] Main scene exists, skipping...
)

if "%NO_ADDON%"=="false" (
    if not exist "addons\orchestrator\orchestrator.gdextension" (
        echo   [+] Installing Orchestrator...
        call :install_orchestrator
    ) else (
        echo   [=] Orchestrator exists, skipping...
    )
)

echo.
echo   ====================================
echo   Done! Project initialized: %PROJECT_NAME%
echo   ====================================
echo.
echo   Next steps:
echo     1. Open Godot and import project.godot
echo     2. Enable Orchestrator in Project Settings - Plugins
echo     3. Start creating your game!
echo.

exit /b 0

:create_project_godot
(
echo ; Godot Engine project file
echo.
echo [application]
echo config/name="%PROJECT_NAME%"
echo config/features=PackedStringArray^("4.5"^)
echo run/main_scene="res://scenes/main.tscn"
echo.
echo [rendering]
echo renderer/rendering_method="forward_plus"
) > "project.godot"
exit /b 0

:create_gitignore
(
echo # Godot
echo .godot/
echo *.import
echo export.cfg
echo export_presets.cfg
echo.
echo # GodotEnv
echo .addons/
echo.
echo # OS
echo .DS_Store
echo Thumbs.db
echo.
echo # IDE
echo .vscode/
echo .idea/
echo.
echo # Build
echo build/
echo *.exe
echo *.apk
echo *.aab
) > ".gitignore"
exit /b 0

:create_main_scene
(
echo [gd_scene format=3 uid="uid://main"]
echo.
echo [node name="Main" type="Node3D"]
) > "scenes\main.tscn"
exit /b 0

:install_orchestrator
set "ORCH_URL=https://github.com/CraterCrash/godot-orchestrator/releases/download/v2.3.2.stable/godot-orchestrator-v2.3.2-stable-plugin.zip"
set "ORCH_ZIP=%TEMP%\orchestrator.zip"

echo   [*] Downloading Orchestrator v2.3.2...
powershell -Command "Invoke-WebRequest -Uri '%ORCH_URL%' -OutFile '%ORCH_ZIP%'" 2>nul
if !errorlevel! neq 0 (
    curl -L -o "%ORCH_ZIP%" "%ORCH_URL%" 2>nul
)

if exist "%ORCH_ZIP%" (
    echo   [*] Extracting...
    powershell -Command "Expand-Archive -Path '%ORCH_ZIP%' -DestinationPath '.' -Force"
    del "%ORCH_ZIP%" 2>nul
    echo   [OK] Orchestrator installed
) else (
    echo   [!] Failed to download Orchestrator
    echo   [!] Download manually from: %ORCH_URL%
)
exit /b 0
