@echo off
setlocal enabledelayedexpansion

:: ============================================
:: gd-addon - Godot Addon Manager
:: ============================================

set "COMMAND=%~1"
set "ADDON_NAME=%~2"

if "%COMMAND%"=="" set "COMMAND=list"

echo.
echo   ====================================
echo   gd-addon - Godot Addon Manager
echo   ====================================
echo.

if /i "%COMMAND%"=="list" (
    echo   Available addon presets:
    echo   ------------------------
    echo     orchestrator    Visual scripting (GDExtension)
    echo     dialogue        Dialogue Manager
    echo     phantom-camera  Smooth camera system
    echo     terrain3d       3D terrain system
    echo.
    if exist "addons" (
        echo   Installed addons:
        echo   -----------------
        dir /b addons 2>nul
        echo.
    )
    exit /b 0
)

if /i "%COMMAND%"=="install" (
    if "%ADDON_NAME%"=="" (
        echo   Usage: gd-addon install [addon-name]
        echo   Example: gd-addon install orchestrator
        echo.
        echo   Run 'gd-addon list' to see available addons
        exit /b 1
    )
    call :install_%ADDON_NAME% 2>nul
    if !errorlevel! neq 0 (
        echo   [ERROR] Unknown addon: %ADDON_NAME%
        echo   Run 'gd-addon list' to see available addons
        exit /b 1
    )
    exit /b 0
)

if /i "%COMMAND%"=="update" (
    if "%ADDON_NAME%"=="" (
        echo   Usage: gd-addon update [addon-name]
        exit /b 1
    )
    echo   [*] Updating %ADDON_NAME%...
    call :install_%ADDON_NAME% 2>nul
    exit /b %errorlevel%
)

echo   Unknown command: %COMMAND%
echo.
echo   Available commands:
echo     list              Show available addons
echo     install [name]    Install addon
echo     update [name]     Update addon
echo.

exit /b 1

:: ============================================
:: Addon installers
:: ============================================

:install_orchestrator
set "URL=https://github.com/CraterCrash/godot-orchestrator/releases/download/v2.3.2.stable/godot-orchestrator-v2.3.2-stable-plugin.zip"
set "ZIP=%TEMP%\orchestrator.zip"

echo   [*] Downloading Orchestrator v2.3.2...
powershell -Command "Invoke-WebRequest -Uri '%URL%' -OutFile '%ZIP%'" 2>nul
if !errorlevel! neq 0 (
    curl -L -o "%ZIP%" "%URL%" 2>nul
)

if exist "%ZIP%" (
    if not exist "addons" mkdir "addons"
    echo   [*] Extracting...
    powershell -Command "Expand-Archive -Path '%ZIP%' -DestinationPath '.' -Force"
    del "%ZIP%" 2>nul
    echo   [OK] Orchestrator installed
) else (
    echo   [!] Failed to download
    exit /b 1
)
exit /b 0

:install_dialogue
set "URL=https://github.com/nathanhoad/godot_dialogue_manager/archive/refs/heads/main.zip"
set "ZIP=%TEMP%\dialogue.zip"

echo   [*] Downloading Dialogue Manager...
powershell -Command "Invoke-WebRequest -Uri '%URL%' -OutFile '%ZIP%'" 2>nul

if exist "%ZIP%" (
    if not exist "addons" mkdir "addons"
    echo   [*] Extracting...
    powershell -Command "Expand-Archive -Path '%ZIP%' -DestinationPath '%TEMP%\dialogue_temp' -Force"
    xcopy /E /Y "%TEMP%\dialogue_temp\godot_dialogue_manager-main\addons\*" "addons\" >nul
    rd /s /q "%TEMP%\dialogue_temp" 2>nul
    del "%ZIP%" 2>nul
    echo   [OK] Dialogue Manager installed
) else (
    echo   [!] Failed to download
    exit /b 1
)
exit /b 0

:install_phantom-camera
set "URL=https://github.com/ramokz/phantom-camera/archive/refs/heads/main.zip"
set "ZIP=%TEMP%\phantom.zip"

echo   [*] Downloading Phantom Camera...
powershell -Command "Invoke-WebRequest -Uri '%URL%' -OutFile '%ZIP%'" 2>nul

if exist "%ZIP%" (
    if not exist "addons" mkdir "addons"
    echo   [*] Extracting...
    powershell -Command "Expand-Archive -Path '%ZIP%' -DestinationPath '%TEMP%\phantom_temp' -Force"
    xcopy /E /Y "%TEMP%\phantom_temp\phantom-camera-main\addons\*" "addons\" >nul
    rd /s /q "%TEMP%\phantom_temp" 2>nul
    del "%ZIP%" 2>nul
    echo   [OK] Phantom Camera installed
) else (
    echo   [!] Failed to download
    exit /b 1
)
exit /b 0

:install_terrain3d
echo   [!] Terrain3D requires manual installation
echo   [!] Download from: https://github.com/TokisanGames/Terrain3D/releases
exit /b 1
