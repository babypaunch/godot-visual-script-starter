@echo off
setlocal enabledelayedexpansion

:: ============================================
:: Godot Game Starter - Global CLI Installer
:: ============================================
:: 이 스크립트는 gd-* 명령어를 전역에서 사용할 수 있도록
:: bin 폴더를 사용자 PATH에 추가합니다.
:: ============================================

echo.
echo   ====================================
echo   Godot Game Starter - CLI Installer
echo   ====================================
echo.

:: 현재 스크립트 위치 확인
set "SCRIPT_DIR=%~dp0"
set "BIN_DIR=%SCRIPT_DIR%bin"

:: bin 폴더 존재 확인
if not exist "%BIN_DIR%" (
    echo   [ERROR] bin folder not found at: %BIN_DIR%
    echo   Please run this script from the godot-visual-script-starter folder.
    exit /b 1
)

echo   Installing CLI tools from:
echo   %BIN_DIR%
echo.

:: 현재 사용자 PATH 가져오기
for /f "tokens=2*" %%A in ('reg query "HKCU\Environment" /v Path 2^>nul') do set "USER_PATH=%%B"

:: 이미 PATH에 있는지 확인
echo "%USER_PATH%" | findstr /I /C:"%BIN_DIR%" >nul
if %errorlevel% equ 0 (
    echo   [OK] Already in PATH
    echo.
    goto :verify
)

:: PATH에 추가
echo   [*] Adding to user PATH...

:: 백업
echo   [*] Backing up current PATH...
echo %USER_PATH% > "%SCRIPT_DIR%path_backup.txt"

:: 새 PATH 설정 (앞에 추가하여 PATH 길이 제한 문제 방지)
if defined USER_PATH (
    set "NEW_PATH=%BIN_DIR%;%USER_PATH%"
) else (
    set "NEW_PATH=%BIN_DIR%"
)

:: 레지스트리 업데이트
reg add "HKCU\Environment" /v Path /t REG_EXPAND_SZ /d "%NEW_PATH%" /f >nul 2>&1
if %errorlevel% neq 0 (
    echo   [ERROR] Failed to update PATH
    echo   Try running as administrator or add manually:
    echo   %BIN_DIR%
    exit /b 1
)

echo   [OK] PATH updated successfully

:: 환경 변수 브로드캐스트 (새 터미널에 적용)
echo   [*] Broadcasting environment change...

:: PowerShell로 환경 변수 변경 알림
powershell -Command "[Environment]::SetEnvironmentVariable('Path', [Environment]::GetEnvironmentVariable('Path', 'User'), 'User')" >nul 2>&1

:verify
echo.
echo   ====================================
echo   Installation Complete!
echo   ====================================
echo.
echo   Available commands:
echo     gd-setup      Install GodotEnv and Godot 4.5
echo     gd-init       Create/initialize Godot project
echo     gd-update     Manage Godot versions
echo     gd-addon      Manage addons
echo.
echo   Quick start:
echo     1. Open a NEW terminal window
echo     2. Run: gd-setup
echo     3. Run: gd-init my-game
echo.
echo   Or initialize existing folder:
echo     cd your-project
echo     gd-init --here
echo.
echo   [!] Please restart your terminal for changes to take effect.
echo.

pause
exit /b 0
