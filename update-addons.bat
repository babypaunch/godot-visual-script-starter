@echo off
chcp 65001 > nul
setlocal EnableDelayedExpansion

:: ============================================================
:: 프로젝트 애드온 업데이트 스크립트
:: 기존 프로젝트의 Orchestrator 등 애드온 업데이트
:: ============================================================

echo.
echo ╔══════════════════════════════════════════════════════════╗
echo ║   프로젝트 애드온 업데이트                               ║
echo ╚══════════════════════════════════════════════════════════╝
echo.

:: ------------------------------------------------------------
:: 프로젝트 경로 확인
:: ------------------------------------------------------------
set PROJECT_PATH=%~1

if "%PROJECT_PATH%"=="" (
    :: 현재 디렉토리에 project.godot가 있는지 확인
    if exist "project.godot" (
        set PROJECT_PATH=%CD%
        echo 현재 디렉토리에서 Godot 프로젝트를 발견했습니다.
    ) else (
        set /p PROJECT_PATH="프로젝트 경로를 입력하세요: "
    )
)

if "%PROJECT_PATH%"=="" (
    echo [오류] 프로젝트 경로가 필요합니다.
    echo 사용법: update-addons.bat [프로젝트경로]
    pause
    exit /b 1
)

:: 경로 확인
if not exist "%PROJECT_PATH%\project.godot" (
    echo [오류] 유효한 Godot 프로젝트가 아닙니다: %PROJECT_PATH%
    echo project.godot 파일을 찾을 수 없습니다.
    pause
    exit /b 1
)

echo 프로젝트 경로: %PROJECT_PATH%
echo.

cd /d "%PROJECT_PATH%"

:: ------------------------------------------------------------
:: addons.json 확인
:: ------------------------------------------------------------
echo [1/3] addons.json 확인 중...

if not exist "addons.json" (
    echo [경고] addons.json 파일이 없습니다.
    echo.
    set /p CREATE_ADDONS="addons.json을 생성할까요? (Y/n): "
    if /i not "!CREATE_ADDONS!"=="n" (
        echo addons.json 생성 중...
        (
echo {
echo   "$schema": "https://chickensoft.games/addons.schema.json",
echo   "path": "addons",
echo   "cache": ".addons",
echo   "addons": {
echo     "orchestrator": {
echo       "url": "https://github.com/CraterCrash/godot-orchestrator.git",
echo       "checkout": "2.3",
echo       "subfolder": "addons/orchestrator"
echo     }
echo   }
echo }
        ) > addons.json
        echo addons.json 생성 완료!
    ) else (
        echo 취소되었습니다.
        pause
        exit /b 1
    )
)

echo     addons.json [OK]

:: ------------------------------------------------------------
:: 현재 addons.json 내용 표시
:: ------------------------------------------------------------
echo.
echo [2/3] 현재 설정된 애드온:
echo.
type addons.json
echo.

:: ------------------------------------------------------------
:: 애드온 업데이트
:: ------------------------------------------------------------
echo.
echo [3/3] 애드온 업데이트 중...
echo.

:: 기존 addons 폴더 백업 여부
if exist "addons" (
    set /p BACKUP="기존 addons 폴더를 백업할까요? (y/N): "
    if /i "!BACKUP!"=="y" (
        set BACKUP_NAME=addons_backup_%date:~0,4%%date:~5,2%%date:~8,2%_%time:~0,2%%time:~3,2%
        set BACKUP_NAME=!BACKUP_NAME: =0!
        echo 백업 중: addons -> !BACKUP_NAME!
        xcopy /E /I /Q "addons" "!BACKUP_NAME!" > nul
    )
)

:: 애드온 재설치
godotenv addons install

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ╔══════════════════════════════════════════════════════════╗
    echo ║   애드온 업데이트 완료!                                  ║
    echo ╚══════════════════════════════════════════════════════════╝
) else (
    echo.
    echo [경고] 애드온 업데이트 중 문제가 발생했을 수 있습니다.
)

echo.
pause
