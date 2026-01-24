@echo off
chcp 65001 > nul
setlocal EnableDelayedExpansion

:: ============================================================
:: Godot + Orchestrator 개발 환경 자동 설정 스크립트
:: 최초 1회 실행
:: ============================================================

echo.
echo ╔══════════════════════════════════════════════════════════╗
echo ║   Godot + Orchestrator 개발 환경 설정                    ║
echo ╚══════════════════════════════════════════════════════════╝
echo.

:: ------------------------------------------------------------
:: Step 1: .NET SDK 확인
:: ------------------------------------------------------------
echo [1/5] .NET SDK 확인 중...

dotnet --version > nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [오류] .NET SDK가 설치되어 있지 않습니다.
    echo.
    echo 다음 링크에서 .NET SDK를 설치해주세요:
    echo https://dotnet.microsoft.com/download
    echo.
    echo 설치 후 이 스크립트를 다시 실행하세요.
    pause
    exit /b 1
)

for /f "tokens=*" %%i in ('dotnet --version') do set DOTNET_VERSION=%%i
echo     .NET SDK 버전: %DOTNET_VERSION% [OK]

:: ------------------------------------------------------------
:: Step 2: NuGet 소스 확인
:: ------------------------------------------------------------
echo.
echo [2/5] NuGet 소스 확인 중...

dotnet nuget list source | findstr "nuget.org" > nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo     nuget.org 소스 추가 중...
    dotnet nuget add source https://api.nuget.org/v3/index.json -n nuget.org
)
echo     NuGet 소스 [OK]

:: ------------------------------------------------------------
:: Step 3: GodotEnv 설치
:: ------------------------------------------------------------
echo.
echo [3/5] GodotEnv 설치 확인 중...

godotenv --version > nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo     GodotEnv 설치 중... (잠시 기다려주세요)
    dotnet tool install --global Chickensoft.GodotEnv
    if %ERRORLEVEL% NEQ 0 (
        echo [오류] GodotEnv 설치 실패
        pause
        exit /b 1
    )
    echo     GodotEnv 설치 완료!
    echo.
    echo     [중요] 환경변수 적용을 위해 새 터미널을 열어야 합니다.
    echo     이 창을 닫고 새 명령 프롬프트에서 다시 실행해주세요.
    pause
    exit /b 0
) else (
    for /f "tokens=*" %%i in ('godotenv --version 2^>nul') do set GODOTENV_VERSION=%%i
    echo     GodotEnv 버전: %GODOTENV_VERSION% [OK]
)

:: ------------------------------------------------------------
:: Step 4: Godot 엔진 설치
:: ------------------------------------------------------------
echo.
echo [4/5] Godot 엔진 설치 중...

:: 설치된 버전 확인
echo     설치된 Godot 버전 확인 중...
godotenv godot list 2>nul

:: 사용 가능한 최신 버전 확인
echo.
echo     사용 가능한 최신 버전 확인 중...

:: 기본으로 4.5.1 설치 (또는 원하는 버전으로 변경)
set GODOT_VERSION=4.5.1

echo.
set /p INSTALL_VERSION="설치할 Godot 버전을 입력하세요 (기본값: %GODOT_VERSION%): "
if "%INSTALL_VERSION%"=="" set INSTALL_VERSION=%GODOT_VERSION%

echo     Godot %INSTALL_VERSION% 설치 중... (다운로드에 시간이 걸릴 수 있습니다)
godotenv godot install %INSTALL_VERSION%

if %ERRORLEVEL% NEQ 0 (
    echo [경고] Godot 설치 중 문제가 발생했을 수 있습니다.
) else (
    echo     Godot %INSTALL_VERSION% 설치 완료!
)

:: 설치한 버전을 활성화
echo     Godot %INSTALL_VERSION% 활성화 중...
godotenv godot use %INSTALL_VERSION%

:: ------------------------------------------------------------
:: Step 5: 환경변수 설정
:: ------------------------------------------------------------
echo.
echo [5/5] 환경변수 설정 중...

godotenv godot env setup

echo     GODOT 환경변수 설정 완료!

:: ------------------------------------------------------------
:: 완료
:: ------------------------------------------------------------
echo.
echo ╔══════════════════════════════════════════════════════════╗
echo ║   설정 완료!                                             ║
echo ╚══════════════════════════════════════════════════════════╝
echo.
echo 다음 명령어로 새 게임 프로젝트를 생성하세요:
echo     new-game.bat [프로젝트이름]
echo.
echo 예시:
echo     new-game.bat my-awesome-game
echo.

pause
