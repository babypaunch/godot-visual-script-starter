# Godot Visual Script Starter

**Godot + Orchestrator 프로젝트 자동화 CLI 도구**

어디서든 `gd-init` 명령으로 새 Godot 프로젝트를 시작하세요.

---

## 설치

```batch
:: 1. 이 저장소 클론 (또는 다운로드)
git clone https://github.com/your-username/godot-visual-script-starter.git

:: 2. 설치 스크립트 실행 (PATH에 추가)
cd godot-visual-script-starter
install.bat

:: 3. 새 터미널 열기 (PATH 적용 필요)

:: 4. GodotEnv + Godot 설치
gd-setup
```

**요구사항:** .NET SDK 6.0+ ([다운로드](https://dotnet.microsoft.com/download))

---

## CLI 명령어

| 명령어 | 설명 |
|--------|------|
| `gd-setup` | GodotEnv와 Godot 4.5 설치 |
| `gd-init` | 새 프로젝트 생성 / 기존 폴더 초기화 |
| `gd-edit` | Godot 에디터 열기 |
| `gd-update` | Godot 버전 관리 |
| `gd-addon` | 애드온 관리 |

---

## `gd-init` - 프로젝트 초기화

### 새 프로젝트 생성

```batch
gd-init my-game
```

### 기존 폴더에 초기화 (핵심 기능!)

```batch
:: 이미 존재하는 폴더로 이동
cd C:\Users\personal\Documents\GitHub\claw-me-if-you-can

:: 현재 폴더에 초기화 (기존 파일 유지, 병합)
gd-init --here

:: 강제 덮어쓰기 모드
gd-init --here --force
```

### 옵션

| 옵션 | 단축 | 설명 |
|------|------|------|
| `--here` | `-h` | 현재 폴더에 초기화 |
| `--force` | `-f` | 기존 파일 덮어쓰기 |
| `--no-addon` | | Orchestrator 설치 안함 |
| `--help` | | 도움말 표시 |

### 생성되는 구조

```
my-game/
├── project.godot       # Godot 프로젝트 파일
├── addons.json         # GodotEnv 애드온 설정
├── .gitignore          # Git 제외 설정
├── scenes/
│   └── main.tscn       # 메인 씬
├── scripts/            # GDScript 파일
├── assets/
│   ├── sprites/
│   ├── audio/
│   ├── fonts/
│   └── models/
└── addons/
    └── orchestrator/   # 자동 설치됨
```

**중요:** 기존 폴더의 `docs/`, `README.md` 등 다른 파일들은 건드리지 않습니다!

---

## `gd-edit` - 에디터 열기

```batch
:: 현재 폴더의 프로젝트를 에디터로 열기
cd my-game
gd-edit

:: 특정 경로의 프로젝트 열기
gd-edit C:\Projects\my-game
```

---

## `gd-update` - 버전 관리

```batch
:: 설치된 버전 목록
gd-update list

:: 특정 버전 설치
gd-update install 4.4

:: 버전 전환
gd-update use 4.4

:: 버전 삭제
gd-update remove 4.3

:: 최신 버전 설치
gd-update latest
```

---

## `gd-addon` - 애드온 관리

```batch
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

---

## 사용 예시

### 예시 1: 완전히 새로운 게임

```batch
cd C:\Projects
gd-init my-awesome-game
cd my-awesome-game
gd-edit
```

### 예시 2: 기존 문서만 있는 폴더에 Godot 추가

```batch
:: claw-me-if-you-can 폴더에는 docs/, README.md만 있음
cd C:\Users\personal\Documents\GitHub\claw-me-if-you-can

:: Godot 프로젝트 파일들 추가 (기존 파일 유지)
gd-init --here

:: 결과:
:: claw-me-if-you-can/
:: ├── docs/              ← 기존 파일 유지
:: ├── README.md          ← 기존 파일 유지
:: ├── project.godot      ← 새로 생성
:: ├── addons.json        ← 새로 생성
:: ├── scenes/            ← 새로 생성
:: └── ...
```

### 예시 3: 여러 Godot 버전 사용

```batch
:: 메인 프로젝트는 4.5
gd-update use 4.5
gd-init main-game

:: 레거시 프로젝트는 4.3
gd-update install 4.3
gd-update use 4.3
cd legacy-game
```

---

## 파일 구조

```
godot-visual-script-starter/
├── bin/                    # CLI 도구들 (PATH에 추가됨)
│   ├── gd-init.bat         # 프로젝트 초기화
│   ├── gd-setup.bat        # 환경 설정
│   ├── gd-edit.bat         # 에디터 열기
│   ├── gd-update.bat       # 버전 관리
│   └── gd-addon.bat        # 애드온 관리
├── install.bat             # PATH에 bin 추가
├── uninstall.bat           # PATH에서 제거
└── README.md
```

---

## 레거시 스크립트 (하위 호환)

기존 스크립트도 계속 사용 가능:

| 스크립트 | CLI 대체 |
|----------|----------|
| `setup-godot-env.bat` | `gd-setup` |
| `new-game.bat` | `gd-init` |
| `update-godot.bat` | `gd-update` |
| `update-addons.bat` | `gd-addon` |

---

## 제거

```batch
uninstall.bat
```

---

## 문제 해결

### "gd-init is not recognized"

새 터미널을 열어야 PATH가 적용됩니다.

### GodotEnv 설치 실패

.NET SDK 8.0 이상 필요:
```batch
:: .NET 버전 확인
dotnet --version

:: .NET 8.0 설치 (없으면)
winget install Microsoft.DotNet.SDK.8
```

### ⚠️ "plugin.cfg 구문 분석 실패" 에러

**원인:** Orchestrator는 GDExtension이지 Plugin이 아님!

**해결:**
1. 텍스트 에디터로 `project.godot` 열기
2. `[editor_plugins]` 섹션에서 orchestrator 관련 항목 제거
3. Godot 재시작

```ini
:: 잘못된 설정 (제거)
[editor_plugins]
enabled=PackedStringArray("res://addons/orchestrator/plugin.cfg")

:: 올바른 설정 (비워두기)
[editor_plugins]
enabled=PackedStringArray()
```

### Orchestrator 탭이 안 보임

GDExtension은 자동 로드됩니다 (Plugins 메뉴에 없는 게 정상):
1. `addons/orchestrator/orchestrator.gdextension` 파일 확인
2. Godot 에디터 **하단**에서 "Orchestrator" 탭 찾기
3. 파일이 없으면: `gd-addon install orchestrator`

---

## 버전 호환성

| Godot | Orchestrator | addons.json checkout |
|-------|--------------|---------------------|
| 4.2.x | v2.0.x | `"checkout": "2.0"` |
| 4.3.x | v2.1.x | `"checkout": "2.1"` |
| 4.4.x | v2.2.x | `"checkout": "2.2"` |
| **4.5.x** | **v2.3.x** | `"checkout": "2.3"` |

---

## 문서

| 문서 | 설명 |
|------|------|
| [CLI 가이드](docs/CLI_GUIDE.md) | CLI 도구 상세 사용법 |
| [Orchestrator 가이드](docs/ORCHESTRATOR_GUIDE.md) | Orchestrator 설치 및 사용법 |

---

## 관련 링크

- [GodotEnv GitHub](https://github.com/chickensoft-games/GodotEnv)
- [Orchestrator 공식 문서](https://docs.cratercrash.space/orchestrator/)
- [Godot 공식 사이트](https://godotengine.org/)

---

## 라이선스

MIT License

---

**최종 업데이트**: 2026-01-24
