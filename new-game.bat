@echo off
chcp 65001 > nul
setlocal EnableDelayedExpansion

:: ============================================================
:: 새 Godot 게임 프로젝트 생성 스크립트
:: Orchestrator 자동 설치 포함
:: ============================================================

echo.
echo ╔══════════════════════════════════════════════════════════╗
echo ║   새 Godot 게임 프로젝트 생성                            ║
echo ╚══════════════════════════════════════════════════════════╝
echo.

:: ------------------------------------------------------------
:: 프로젝트 이름 확인
:: ------------------------------------------------------------
set PROJECT_NAME=%~1

if "%PROJECT_NAME%"=="" (
    set /p PROJECT_NAME="프로젝트 이름을 입력하세요: "
)

if "%PROJECT_NAME%"=="" (
    echo [오류] 프로젝트 이름이 필요합니다.
    echo 사용법: new-game.bat [프로젝트이름]
    pause
    exit /b 1
)

:: 프로젝트 경로 설정 (현재 디렉토리 기준)
set PROJECT_PATH=%CD%\%PROJECT_NAME%

echo.
echo 프로젝트 이름: %PROJECT_NAME%
echo 프로젝트 경로: %PROJECT_PATH%
echo.

:: ------------------------------------------------------------
:: GodotEnv 확인
:: ------------------------------------------------------------
echo [1/6] GodotEnv 확인 중...

godotenv --version > nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [오류] GodotEnv가 설치되어 있지 않습니다.
    echo 먼저 setup-godot-env.bat를 실행해주세요.
    pause
    exit /b 1
)
echo     GodotEnv [OK]

:: ------------------------------------------------------------
:: 프로젝트 폴더 생성
:: ------------------------------------------------------------
echo.
echo [2/6] 프로젝트 폴더 생성 중...

if exist "%PROJECT_PATH%" (
    echo [오류] 이미 존재하는 폴더입니다: %PROJECT_PATH%
    set /p OVERWRITE="덮어쓰시겠습니까? (y/N): "
    if /i not "!OVERWRITE!"=="y" (
        echo 취소되었습니다.
        pause
        exit /b 1
    )
    rmdir /s /q "%PROJECT_PATH%"
)

mkdir "%PROJECT_PATH%"
cd /d "%PROJECT_PATH%"

echo     폴더 생성 완료: %PROJECT_PATH%

:: ------------------------------------------------------------
:: project.godot 생성
:: ------------------------------------------------------------
echo.
echo [3/6] Godot 프로젝트 파일 생성 중...

(
echo ; Engine configuration file.
echo ; It's best edited using the editor UI and not directly,
echo ; since the parameters that go here are not all obvious.
echo ;
echo ; Format:
echo ;   [section] ; section goes between []
echo ;   param=value ; assign values to parameters
echo.
echo config_version=5
echo.
echo [application]
echo.
echo config/name="%PROJECT_NAME%"
echo config/features=PackedStringArray^("4.5", "Forward Plus"^)
echo config/icon="res://icon.svg"
echo.
echo [editor_plugins]
echo.
echo enabled=PackedStringArray^("res://addons/orchestrator/plugin.cfg"^)
echo.
echo [rendering]
echo.
echo renderer/rendering_method="forward_plus"
) > project.godot

echo     project.godot 생성 완료

:: ------------------------------------------------------------
:: addons.json 생성 (Orchestrator 포함)
:: ------------------------------------------------------------
echo.
echo [4/6] addons.json 생성 중...

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

echo     addons.json 생성 완료

:: ------------------------------------------------------------
:: .gitignore 생성
:: ------------------------------------------------------------
echo.
echo [5/6] .gitignore 생성 중...

(
echo # Godot 4+ specific ignores
echo .godot/
echo.
echo # Godot-specific ignores
echo *.translation
echo export.cfg
echo export_presets.cfg
echo.
echo # Imported textures and samples
echo .import/
echo.
echo # Addons managed by GodotEnv
echo addons/
echo .addons/
echo.
echo # Mono-specific ignores
echo .mono/
echo data_*/
echo mono_crash.*.json
echo.
echo # OS generated
echo .DS_Store
echo Thumbs.db
echo.
echo # IDE
echo .idea/
echo .vscode/
echo *.swp
echo *.swo
echo *~
) > .gitignore

echo     .gitignore 생성 완료

:: ------------------------------------------------------------
:: 기본 아이콘 생성 (SVG)
:: ------------------------------------------------------------
(
echo ^<svg xmlns="http://www.w3.org/2000/svg" width="128" height="128"^>
echo   ^<rect width="128" height="128" fill="#478cbf"/^>
echo   ^<text x="64" y="80" font-size="48" text-anchor="middle" fill="white"^>G^</text^>
echo ^</svg^>
) > icon.svg

:: ------------------------------------------------------------
:: 기본 폴더 구조 생성
:: ------------------------------------------------------------
mkdir scenes 2>nul
mkdir scripts 2>nul
mkdir assets 2>nul
mkdir assets\sprites 2>nul
mkdir assets\audio 2>nul
mkdir assets\fonts 2>nul

:: ------------------------------------------------------------
:: Orchestrator 애드온 설치
:: ------------------------------------------------------------
echo.
echo [6/6] Orchestrator 설치 중... (다운로드에 시간이 걸릴 수 있습니다)

godotenv addons install

if %ERRORLEVEL% NEQ 0 (
    echo [경고] 애드온 설치 중 문제가 발생했을 수 있습니다.
    echo 수동으로 다음 명령을 실행해보세요:
    echo     cd %PROJECT_PATH%
    echo     godotenv addons install
) else (
    echo     Orchestrator 설치 완료!
)

:: ------------------------------------------------------------
:: 완료
:: ------------------------------------------------------------
echo.
echo ╔══════════════════════════════════════════════════════════╗
echo ║   프로젝트 생성 완료!                                    ║
echo ╚══════════════════════════════════════════════════════════╝
echo.
echo 프로젝트 경로: %PROJECT_PATH%
echo.
echo 폴더 구조:
echo     %PROJECT_NAME%/
echo     ├── addons/orchestrator/    (Orchestrator 플러그인)
echo     ├── assets/
echo     │   ├── sprites/
echo     │   ├── audio/
echo     │   └── fonts/
echo     ├── scenes/
echo     ├── scripts/
echo     ├── addons.json
echo     ├── project.godot
echo     └── icon.svg
echo.
echo 다음 명령으로 Godot을 실행하세요:
echo     1. Godot 에디터에서 프로젝트 열기
echo     2. 또는 명령어: godot --editor --path "%PROJECT_PATH%"
echo.

set /p OPEN_GODOT="지금 Godot 에디터를 열까요? (Y/n): "
if /i not "%OPEN_GODOT%"=="n" (
    echo Godot 에디터를 여는 중...
    start "" godot --editor --path "%PROJECT_PATH%"
)

pause
