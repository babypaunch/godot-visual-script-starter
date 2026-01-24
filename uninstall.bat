@echo off
setlocal enabledelayedexpansion

:: ============================================
:: Godot Game Starter - Uninstaller
:: ============================================

echo.
echo   ====================================
echo   Godot Game Starter - Uninstaller
echo   ====================================
echo.

set "SCRIPT_DIR=%~dp0"
set "BIN_DIR=%SCRIPT_DIR%bin"

:: 현재 사용자 PATH 가져오기
for /f "tokens=2*" %%A in ('reg query "HKCU\Environment" /v Path 2^>nul') do set "USER_PATH=%%B"

:: PATH에서 제거
echo   [*] Removing from PATH...

:: BIN_DIR를 PATH에서 제거
set "NEW_PATH=!USER_PATH:%BIN_DIR%;=!"
set "NEW_PATH=!NEW_PATH:;%BIN_DIR%=!"
set "NEW_PATH=!NEW_PATH:%BIN_DIR%=!"

:: 레지스트리 업데이트
reg add "HKCU\Environment" /v Path /t REG_EXPAND_SZ /d "%NEW_PATH%" /f >nul 2>&1

echo   [OK] Removed from PATH
echo.
echo   CLI tools uninstalled.
echo   Restart your terminal for changes to take effect.
echo.

pause
exit /b 0
