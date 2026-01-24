# Godot Visual Script Starter - CLI 가이드

**버전**: 1.0
**최종 업데이트**: 2026-01-24

---

## 개요

> "어디서든 `gd-init`으로 Godot 프로젝트 시작"

Godot Visual Script Starter는 전역 CLI 도구로, 터미널 어디에서든 Godot 프로젝트를 생성하고 관리할 수 있습니다.

### 주요 특징

- **전역 명령어**: `claude`처럼 어디서든 `gd-init` 사용 가능
- **기존 폴더 병합**: 이미 존재하는 폴더에도 Godot 프로젝트 추가 가능
- **자동 애드온 설치**: Orchestrator 자동 설정
- **버전 관리**: 여러 Godot 버전 설치 및 전환

---

## 1. 설치

### 1.1 요구사항

| 요구사항 | 버전 | 다운로드 |
|----------|------|----------|
| Windows | 10/11 | - |
| .NET SDK | 6.0+ | [다운로드](https://dotnet.microsoft.com/download) |

### 1.2 설치 과정

```batch
:: 1. 저장소 클론
git clone https://github.com/your-username/godot-visual-script-starter.git
cd godot-visual-script-starter

:: 2. CLI 도구 설치 (PATH에 추가)
install.bat

:: 3. 새 터미널 열기 (필수! PATH 적용)

:: 4. GodotEnv + Godot 설치
gd-setup
```

### 1.3 설치 확인

```batch
:: 새 터미널에서 확인
gd-init --help
```

출력:
```
  gd-init - Godot Project Initializer
  ====================================

  Usage: gd-init [project-name] [options]

  Options:
    --here, -h     Initialize in current folder
    --force, -f    Overwrite existing files
    --no-addon     Skip Orchestrator installation
    --help         Show this help
```

---

## 2. CLI 명령어 목록

| 명령어 | 설명 | 주 사용 시점 |
|--------|------|-------------|
| `gd-setup` | GodotEnv + Godot 설치 | 최초 1회 |
| `gd-init` | 프로젝트 생성/초기화 | 새 프로젝트 시작 |
| `gd-update` | Godot 버전 관리 | 버전 변경 시 |
| `gd-addon` | 애드온 관리 | 애드온 추가/업데이트 |

---

## 3. gd-setup - 환경 설정

### 기능

- .NET SDK 확인
- GodotEnv 설치 (Godot 버전 관리 도구)
- Godot 4.5 설치
- 기본 버전 설정

### 사용법

```batch
gd-setup
```

### 출력 예시

```
  ====================================
  gd-setup - Godot Environment Setup
  ====================================

  [OK] .NET SDK found
  [OK] GodotEnv already installed
  [*] Checking for updates...
  [OK] Godot 4.5 already installed
  [*] Setting Godot 4.5 as default...

  ====================================
  Setup Complete!
  ====================================

  Installed:
    - GodotEnv (global tool)
    - Godot 4.5

  Commands available:
    gd-init [name]    Create new Godot project
    gd-init --here    Initialize in current folder
    gd-update         Update Godot version
    gd-addon          Manage addons
```

---

## 4. gd-init - 프로젝트 초기화

### 기능

- 새 Godot 프로젝트 생성
- **기존 폴더에 병합** (핵심 기능!)
- Orchestrator 자동 설치
- 기본 폴더 구조 생성

### 사용법

```batch
:: 새 프로젝트 생성
gd-init my-game

:: 현재 폴더에 초기화 (기존 파일 유지)
gd-init --here

:: 강제 덮어쓰기
gd-init my-game --force
gd-init --here -f

:: Orchestrator 없이
gd-init my-game --no-addon
```

### 옵션

| 옵션 | 단축 | 설명 |
|------|------|------|
| `--here` | `-h` | 현재 폴더에 초기화 (폴더명을 프로젝트명으로) |
| `--force` | `-f` | 기존 파일 덮어쓰기 |
| `--no-addon` | | Orchestrator 설치 안함 |
| `--help` | | 도움말 표시 |

### 생성되는 파일/폴더

```
project/
├── project.godot       # Godot 프로젝트 파일
├── addons.json         # GodotEnv 애드온 설정
├── .gitignore          # Git 제외 설정
├── scenes/
│   └── main.tscn       # 메인 씬 (Node3D)
├── scripts/            # GDScript 파일
├── assets/
│   ├── sprites/        # 2D 이미지
│   ├── audio/          # 사운드
│   ├── fonts/          # 폰트
│   └── models/         # 3D 모델
└── addons/
    └── orchestrator/   # 비주얼 스크립팅 (자동 설치)
```

### 병합 동작 (--here)

| 상황 | 동작 |
|------|------|
| 파일이 없음 | 새로 생성 |
| 파일이 있음 (일반 모드) | 건너뜀 (기존 유지) |
| 파일이 있음 (--force) | 덮어쓰기 |
| docs/, README.md 등 | 절대 건드리지 않음 |

### 예시: 기존 문서 폴더에 Godot 추가

```batch
:: 상황: claw-me-if-you-can 폴더에 docs/만 있음
cd C:\Users\personal\Documents\GitHub\claw-me-if-you-can

:: 초기화 (기존 파일 유지)
gd-init --here

:: 결과:
:: claw-me-if-you-can/
:: ├── docs/              ← 기존 유지
:: │   ├── GDD.md
:: │   ├── ARCHITECTURE.md
:: │   └── ...
:: ├── README.md          ← 기존 유지
:: ├── project.godot      ← 새로 생성
:: ├── addons.json        ← 새로 생성
:: ├── scenes/            ← 새로 생성
:: └── addons/            ← 새로 생성
```

---

## 5. gd-update - 버전 관리

### 기능

- 설치된 Godot 버전 목록
- 새 버전 설치
- 버전 전환
- 버전 삭제

### 사용법

```batch
:: 설치된 버전 목록
gd-update list

:: 특정 버전 설치
gd-update install 4.4
gd-update install 4.3.1

:: 버전 전환
gd-update use 4.4

:: 버전 삭제
gd-update remove 4.3

:: 최신 버전 설치
gd-update latest
```

### 명령어

| 명령어 | 설명 |
|--------|------|
| `list` | 설치된 버전 표시 |
| `install [VER]` | 특정 버전 설치 |
| `use [VER]` | 버전 전환 |
| `remove [VER]` | 버전 삭제 |
| `latest` | 최신 버전 설치 |

### 예시: 여러 버전 사용

```batch
:: 프로젝트 A는 4.5
gd-update use 4.5
cd project-a
godot project.godot

:: 프로젝트 B는 4.3 (레거시)
gd-update use 4.3
cd project-b
godot project.godot
```

---

## 6. gd-addon - 애드온 관리

### 기능

- addons.json의 애드온 설치
- 애드온 업데이트
- 애드온 프리셋 추가

### 사용법

```batch
:: 프로젝트 폴더에서 실행
cd my-game

:: addons.json의 모든 애드온 설치
gd-addon install

:: 애드온 업데이트
gd-addon update

:: 설정된 애드온 목록
gd-addon list

:: 애드온 프리셋 추가
gd-addon add orchestrator
gd-addon add dialogue
gd-addon add phantom-camera
gd-addon add terrain3d
```

### 명령어

| 명령어 | 설명 |
|--------|------|
| `install` | addons.json의 모든 애드온 설치 |
| `update` | 설치된 애드온 업데이트 |
| `list` | 설정된 애드온 표시 |
| `add [name]` | 애드온 프리셋 추가 |

### 애드온 프리셋

| 프리셋 | 설명 | GitHub |
|--------|------|--------|
| `orchestrator` | 비주얼 스크립팅 | CraterCrash/godot-orchestrator |
| `dialogue` | 대화 시스템 | nathanhoad/godot_dialogue_manager |
| `phantom-camera` | 스무스 카메라 | ramokz/phantom-camera |
| `terrain3d` | 3D 지형 | TokisanGames/Terrain3D |

---

## 7. 파일 구조

### godot-visual-script-starter 구조

```
godot-visual-script-starter/
├── bin/                    # CLI 도구들 (PATH에 추가됨)
│   ├── gd-init.bat         # 프로젝트 초기화
│   ├── gd-setup.bat        # 환경 설정
│   ├── gd-update.bat       # 버전 관리
│   └── gd-addon.bat        # 애드온 관리
├── docs/
│   ├── CLI_GUIDE.md        # 이 문서
│   └── ORCHESTRATOR_GUIDE.md
├── install.bat             # PATH에 bin 추가
├── uninstall.bat           # PATH에서 제거
├── README.md               # 간단한 사용법
└── (레거시 스크립트들)
    ├── setup-godot-env.bat
    ├── new-game.bat
    ├── update-godot.bat
    └── update-addons.bat
```

### 설치 후 PATH

```
%USERPROFILE%\.dotnet\tools     # GodotEnv
godot-visual-script-starter\bin          # gd-* 명령어
```

---

## 8. 사용 시나리오

### 시나리오 1: 완전히 새로운 게임 시작

```batch
:: 1. 원하는 위치로 이동
cd C:\Projects

:: 2. 새 프로젝트 생성
gd-init my-awesome-game

:: 3. Godot 에디터 열기
cd my-awesome-game
godot project.godot
```

### 시나리오 2: 기획 문서가 있는 폴더에 Godot 추가

```batch
:: 상황: GitHub에서 클론한 문서 프로젝트
:: claw-me-if-you-can/ 에 docs/, README.md만 있음

cd C:\Users\personal\Documents\GitHub\claw-me-if-you-can

:: Godot 프로젝트 파일 추가 (문서는 그대로!)
gd-init --here

:: 확인
ls
:: docs/  README.md  project.godot  scenes/  addons/  ...
```

### 시나리오 3: 다른 버전의 Godot 사용

```batch
:: 4.3 버전 필요한 프로젝트
gd-update install 4.3
gd-update use 4.3
gd-init legacy-game

:: 다시 4.5로 복귀
gd-update use 4.5
```

### 시나리오 4: 애드온 추가

```batch
cd my-game

:: 대화 시스템 추가
gd-addon add dialogue

:: addons.json 수동 편집 후 설치
gd-addon install
```

---

## 9. GDExtension vs Plugin (중요!)

### 핵심 차이점

Godot의 확장 기능에는 두 가지 타입이 있습니다:

| 구분 | GDExtension | Plugin |
|------|-------------|--------|
| **파일** | `.gdextension` | `plugin.cfg` |
| **언어** | C++ (네이티브) | GDScript |
| **로딩** | **자동 로드** | 수동 활성화 필요 |
| **성능** | 빠름 | 일반 |
| **설정 위치** | Project Settings 불필요 | Project → Plugins |

### Orchestrator는 GDExtension

> **Orchestrator는 GDExtension입니다. Plugin이 아닙니다!**

```
addons/orchestrator/
├── orchestrator.gdextension    ← GDExtension (자동 로드)
├── bin/                        ← C++ 바이너리
└── icons/
```

**확인 방법:**
```
addons/orchestrator/ 폴더에 orchestrator.gdextension 파일이 있으면 정상
```

### GDExtension의 특징

1. **자동 로드**: Godot이 프로젝트 열 때 자동으로 감지하고 로드
2. **플러그인 목록에 없음**: Project Settings → Plugins에 표시되지 않음
3. **project.godot에 설정 불필요**: `editor_plugins` 섹션 추가하지 마세요
4. **Orchestrator 탭 확인**: 에디터 하단에 "Orchestrator" 탭이 나타나면 정상 작동 중

### 주의: project.godot 설정

**❌ 하지 마세요:**
```ini
[editor_plugins]
enabled=PackedStringArray("res://addons/orchestrator/plugin.cfg")
```

**✅ 올바른 설정 (비워두거나 생략):**
```ini
[editor_plugins]
enabled=PackedStringArray()
```

GDExtension은 자동 로드되므로 `editor_plugins` 설정이 필요 없습니다.

---

## 10. 문제 해결

### "gd-init is not recognized"

**원인:** PATH가 적용되지 않음

**해결:**
1. 새 터미널 (cmd/PowerShell) 열기
2. 또는 수동으로 PATH 확인:
```batch
echo %PATH% | findstr godot-visual-script-starter
```

### "GodotEnv not found"

**원인:** gd-setup을 실행하지 않음

**해결:**
```batch
gd-setup
```

### ".NET SDK not found"

**원인:** .NET SDK 미설치 (8.0 이상 필요)

**해결:**
```batch
:: .NET 8.0 설치 (winget 사용)
winget install Microsoft.DotNet.SDK.8

:: 또는 수동 다운로드
```
[.NET SDK 다운로드](https://dotnet.microsoft.com/download) 후 재시도

### ⚠️ "plugin.cfg 구문 분석 실패" 에러

**에러 메시지:**
```
다음 경로에 있는 애드온 플러그인을 활성화할 수 없음:
'res://addons/orchestrator/plugin.cfg' 구성의 구문 분석을 실패했습니다.
```

**원인:** Orchestrator는 GDExtension인데 Plugin으로 취급하려 함

**해결:**
1. `project.godot` 파일 열기 (텍스트 에디터)
2. `[editor_plugins]` 섹션 찾기
3. Orchestrator 관련 항목 제거:

```ini
:: 수정 전 (잘못된 설정)
[editor_plugins]
enabled=PackedStringArray("res://addons/orchestrator/plugin.cfg")

:: 수정 후 (올바른 설정)
[editor_plugins]
enabled=PackedStringArray()
```

4. Godot 재시작
5. 하단에 "Orchestrator" 탭 확인

### Orchestrator 탭이 안 보임

**원인 1:** GDExtension 파일이 없음

**확인:**
```batch
dir addons\orchestrator\orchestrator.gdextension
```

파일이 없으면 재설치:
```batch
gd-addon install orchestrator
```

**원인 2:** Godot 버전 불일치

Godot 4.5에는 Orchestrator v2.3.x가 필요합니다.
[Orchestrator 릴리스](https://github.com/CraterCrash/godot-orchestrator/releases)에서 버전 확인

### 기존 파일이 덮어써짐

**원인:** `--force` 옵션 사용

**해결:**
- `--force` 없이 실행하면 기존 파일 유지
- 실수로 덮어썼다면 git으로 복구

---

## 11. 버전 호환성

### Godot ↔ Orchestrator

| Godot | Orchestrator | addons.json checkout |
|-------|--------------|---------------------|
| 4.2.x | v2.0.x | `"checkout": "2.0"` |
| 4.3.x | v2.1.x | `"checkout": "2.1"` |
| 4.4.x | v2.2.x | `"checkout": "2.2"` |
| **4.5.x** | **v2.3.x** | `"checkout": "2.3"` |

Godot 버전을 변경하면 `addons.json`의 `checkout` 값도 변경 필요:

```json
{
  "addons": {
    "orchestrator": {
      "url": "https://github.com/CraterCrash/godot-orchestrator.git",
      "checkout": "2.3",  // ← Godot 버전에 맞게 변경
      "subfolder": "addons/orchestrator"
    }
  }
}
```

---

## 12. 제거

### CLI 도구 제거

```batch
cd godot-visual-script-starter
uninstall.bat
```

### GodotEnv 제거

```batch
dotnet tool uninstall --global GodotEnv
```

### Godot 제거

```batch
gd-update remove 4.5
gd-update remove 4.4
:: 모든 버전 삭제
```

---

## 13. 관련 문서

| 문서 | 설명 |
|------|------|
| [README.md](../README.md) | 빠른 시작 가이드 |
| [ORCHESTRATOR_GUIDE.md](ORCHESTRATOR_GUIDE.md) | Orchestrator 상세 가이드 |
| [GodotEnv GitHub](https://github.com/chickensoft-games/GodotEnv) | GodotEnv 공식 문서 |
| [Orchestrator Docs](https://docs.cratercrash.space/orchestrator/) | Orchestrator 공식 문서 |

---

## 변경 이력

| 버전 | 날짜 | 변경 내용 |
|------|------|----------|
| 1.1 | 2026-01-24 | GDExtension vs Plugin 섹션 추가, plugin.cfg 에러 해결 방법 추가 |
| 1.0 | 2026-01-24 | 초기 문서 작성 |
