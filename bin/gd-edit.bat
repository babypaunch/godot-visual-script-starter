@echo off
chcp 65001 > nul

:: ============================================================
:: Godot 에디터 열기
:: 현재 폴더 또는 지정된 경로의 프로젝트를 에디터로 실행
:: ============================================================

:: 도움말 표시
if "%~1"=="--help" goto :show_help
if "%~1"=="-h" goto :show_help
if "%~1"=="/?" goto :show_help

:: 경로 결정
set "PROJECT_PATH=%CD%"
if not "%~1"=="" set "PROJECT_PATH=%~1"

:: project.godot 확인
if not exist "%PROJECT_PATH%\project.godot" goto :no_project

:: Godot 에디터 실행
echo Godot 에디터 열기: %PROJECT_PATH%
start "" godot -e --path "%PROJECT_PATH%"
exit /b 0

:no_project
echo.
echo [오류] project.godot을 찾을 수 없습니다.
echo.
echo 현재 경로: %PROJECT_PATH%
echo.
echo 해결 방법:
echo   1. Godot 프로젝트 폴더로 이동 후 실행
echo   2. 또는: gd-edit [프로젝트경로]
echo   3. 새 프로젝트 생성: gd-init [이름]
echo.
exit /b 1

:show_help
echo.
echo 사용법: gd-edit [경로]
echo.
echo Godot 에디터로 프로젝트를 엽니다.
echo.
echo 옵션:
echo   [경로]      프로젝트 경로 (기본값: 현재 폴더)
echo   --help, -h  도움말 표시
echo.
echo 예시:
echo   gd-edit                           현재 폴더의 프로젝트 열기
echo   gd-edit C:\Projects\my-game       특정 경로의 프로젝트 열기
echo.
exit /b 0
