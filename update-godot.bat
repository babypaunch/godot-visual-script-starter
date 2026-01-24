@echo off
chcp 65001 > nul
setlocal EnableDelayedExpansion

:: ============================================================
:: Godot 엔진 업데이트 스크립트
:: ============================================================

echo.
echo ╔══════════════════════════════════════════════════════════╗
echo ║   Godot 엔진 업데이트                                    ║
echo ╚══════════════════════════════════════════════════════════╝
echo.

:: ------------------------------------------------------------
:: GodotEnv 확인
:: ------------------------------------------------------------
echo [1/4] GodotEnv 확인 중...

godotenv --version > nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [오류] GodotEnv가 설치되어 있지 않습니다.
    echo 먼저 setup-godot-env.bat를 실행해주세요.
    pause
    exit /b 1
)
echo     GodotEnv [OK]

:: ------------------------------------------------------------
:: 현재 설치된 버전 확인
:: ------------------------------------------------------------
echo.
echo [2/4] 현재 설치된 Godot 버전:
echo.
godotenv godot list
echo.

:: ------------------------------------------------------------
:: 사용 가능한 원격 버전 확인
:: ------------------------------------------------------------
echo [3/4] 사용 가능한 최신 버전 확인 중...
echo.
echo 최근 릴리스 버전 (상위 10개):
godotenv godot list -r 2>nul | findstr /r "^4\." | head -10 2>nul

echo.
echo ─────────────────────────────────────────────────────────────
echo.

:: ------------------------------------------------------------
:: 업데이트 옵션
:: ------------------------------------------------------------
echo [4/4] 업데이트 옵션:
echo.
echo   1. 특정 버전 설치
echo   2. 설치된 버전으로 전환
echo   3. 버전 삭제
echo   4. 종료
echo.

set /p CHOICE="선택하세요 (1-4): "

if "%CHOICE%"=="1" goto INSTALL_VERSION
if "%CHOICE%"=="2" goto SWITCH_VERSION
if "%CHOICE%"=="3" goto UNINSTALL_VERSION
if "%CHOICE%"=="4" goto END

echo 잘못된 선택입니다.
goto END

:: ------------------------------------------------------------
:: 새 버전 설치
:: ------------------------------------------------------------
:INSTALL_VERSION
echo.
set /p NEW_VERSION="설치할 버전을 입력하세요 (예: 4.5.1): "

if "%NEW_VERSION%"=="" (
    echo 버전을 입력해주세요.
    goto END
)

echo.
echo Godot %NEW_VERSION% 설치 중...
godotenv godot install %NEW_VERSION%

if %ERRORLEVEL% EQU 0 (
    echo.
    set /p ACTIVATE="이 버전을 활성화할까요? (Y/n): "
    if /i not "!ACTIVATE!"=="n" (
        godotenv godot use %NEW_VERSION%
        echo Godot %NEW_VERSION% 활성화 완료!
    )
)
goto END

:: ------------------------------------------------------------
:: 버전 전환
:: ------------------------------------------------------------
:SWITCH_VERSION
echo.
echo 설치된 버전:
godotenv godot list
echo.
set /p SWITCH_TO="전환할 버전을 입력하세요: "

if "%SWITCH_TO%"=="" (
    echo 버전을 입력해주세요.
    goto END
)

godotenv godot use %SWITCH_TO%
echo Godot %SWITCH_TO% 로 전환 완료!
goto END

:: ------------------------------------------------------------
:: 버전 삭제
:: ------------------------------------------------------------
:UNINSTALL_VERSION
echo.
echo 설치된 버전:
godotenv godot list
echo.
set /p REMOVE_VERSION="삭제할 버전을 입력하세요: "

if "%REMOVE_VERSION%"=="" (
    echo 버전을 입력해주세요.
    goto END
)

set /p CONFIRM="정말 Godot %REMOVE_VERSION% 을 삭제할까요? (y/N): "
if /i "%CONFIRM%"=="y" (
    godotenv godot uninstall %REMOVE_VERSION%
    echo Godot %REMOVE_VERSION% 삭제 완료!
)
goto END

:: ------------------------------------------------------------
:: 종료
:: ------------------------------------------------------------
:END
echo.
pause
