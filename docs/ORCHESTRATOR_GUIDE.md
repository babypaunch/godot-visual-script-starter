# Orchestrator 시작 가이드

**작성일**: 2026-01-23

Godot 엔진을 위한 노코드 비주얼 스크립팅 플러그인 **Orchestrator** 설치 및 사용 가이드입니다.

---

## 목차

1. [Orchestrator 소개](#1-orchestrator-소개)
2. [Godot 엔진 설치](#2-godot-엔진-설치)
3. [버전 호환성](#3-버전-호환성)
4. [Orchestrator 설치](#4-orchestrator-설치)
5. [첫 번째 Orchestration 만들기](#5-첫-번째-orchestration-만들기)
6. [핵심 개념](#6-핵심-개념)
7. [학습 리소스](#7-학습-리소스)
8. [노코드 대안 비교](#8-노코드-대안-비교)

---

## 1. Orchestrator 소개

### 개요

Orchestrator는 **Godot 4.2+ 전용 비주얼 스크립팅 플러그인**입니다. Unreal Engine의 Blueprint와 유사한 노드 기반 방식으로, 코드 작성 없이 게임 로직을 만들 수 있습니다.

### 왜 Orchestrator인가?

- Godot 4.0에서 내장 Visual Scripting이 제거됨
- Orchestrator가 GDExtension 기반의 대체 솔루션으로 등장
- C++ 기반으로 성능 우수
- Apache 2.0 라이선스 (완전 무료)

### GDExtension vs Plugin (중요!)

> **Orchestrator는 GDExtension입니다. 일반 Plugin이 아닙니다!**

| 구분 | GDExtension | Plugin |
|------|-------------|--------|
| **파일** | `.gdextension` | `plugin.cfg` |
| **로딩** | **자동 로드** | 수동 활성화 필요 |
| **위치** | Project Settings 불필요 | Project → Plugins |

**핵심 포인트:**
- GDExtension은 Godot이 프로젝트를 열 때 **자동으로 로드**됨
- Project Settings → Plugins에 표시되지 않음 (정상)
- `project.godot`에 `editor_plugins` 설정 추가 **불필요**
- 에디터 하단에 "Orchestrator" 탭이 나타나면 정상 작동

### 주요 기능

| 기능 | 설명 |
|------|------|
| **노드 라이브러리** | Flow Control, Logic, Math, Variables 등 수백 개 노드 |
| **드래그앤드롭** | Scene Node, Properties, Resources 직접 끌어다 사용 |
| **커스텀 함수** | 재사용 가능한 로직 모듈화 |
| **대화 시스템** | NPC 대화 구성 내장 |
| **Godot 시그널** | 이벤트 시스템 완벽 지원 |
| **복잡한 데이터** | Array, Dictionary 등 지원 |

### 장단점

| 장점 | 단점 |
|------|------|
| 완전 무료 (Apache 2.0) | Godot 설치 필요 |
| Godot와 완벽 통합 | Godot 버전 호환성 주의 필요 |
| GDScript/C#과 혼용 가능 | 초기 학습 곡선 존재 |
| 성능 우수 (C++ 기반) | Godot 기본 지식 필요 |
| 3D 게임도 가능 | |

---

## 2. Godot 엔진 설치

### 다운로드

**공식 다운로드 페이지**: https://godotengine.org/download/windows/

### 버전 선택

| 버전 | 설명 | 추천 |
|------|------|------|
| **Godot Engine** | 표준 버전, GDScript 사용 | **추천** |
| **Godot Engine - .NET** | C# 지원 버전 | C# 필요시만 |

### 설치 방법

```bash
1. 공식 사이트에서 ZIP 파일 다운로드
2. 원하는 폴더에 압축 해제 (예: C:\Godot)
3. Godot_v4.x.x_win64.exe 실행
```

**참고**: Godot은 **포터블 앱**으로, 별도 설치 과정이 필요 없습니다. 압축만 풀면 바로 실행 가능합니다.

### 시스템 요구사항

| 항목 | 요구사항 |
|------|----------|
| **권장** | Vulkan 1.0 호환 GPU |
| **최소** | OpenGL 3.3 / OpenGL ES 3.0 호환 GPU |
| **.NET 버전** | .NET SDK 추가 필요 |

---

## 3. 버전 호환성

### 중요 경고

> **잘못된 버전의 Orchestrator를 Godot과 함께 사용하면 예기치 않은 동작이나 충돌이 발생할 수 있습니다.**

### 호환성 표

| Godot 버전 | Orchestrator 버전 | 브랜치 |
|-----------|------------------|--------|
| 4.2.x | v2.0.x | 2.0 branch |
| 4.3.x | v2.1.x | 2.1 branch |
| 4.4.x | v2.2.x | 2.2 branch |
| **4.5.x** | **v2.3.x** | 2.3 branch |
| 4.6.x | v2.4.x | main branch |

### 추천 조합

```
Godot 4.5.x (최신 안정 버전) + Orchestrator v2.3.x
```

---

## 4. Orchestrator 설치

### 방법 A: Godot Asset Library (추천)

가장 쉬운 방법입니다.

```
1. Godot 실행
2. 새 프로젝트 생성 또는 기존 프로젝트 열기
3. 상단 메뉴에서 "AssetLib" 탭 클릭
4. 검색창에 "Orchestrator" 입력
5. 검색 결과에서 "Orchestrator" 선택
6. "Download" 버튼 클릭
7. 다운로드 완료 후 "Install" 클릭
8. 프로젝트 재시작
```

### 방법 B: 수동 설치 (GitHub)

최신 버전이나 특정 버전이 필요할 때 사용합니다.

```
1. GitHub 릴리스 페이지 접속:
   https://github.com/CraterCrash/godot-orchestrator/releases

2. Godot 버전에 맞는 릴리스 다운로드
   (예: godot-orchestrator-v2.3.2-stable-plugin.zip)

3. ZIP 파일 압축 해제

4. addons/orchestrator 폴더를
   프로젝트의 addons/ 폴더에 복사

   프로젝트 구조:
   your_project/
   ├── addons/
   │   └── orchestrator/
   │       ├── orchestrator.gdextension  ← 이 파일이 있어야 함!
   │       ├── bin/
   │       └── icons/
   ├── project.godot
   └── ...

5. Godot 재시작

6. 하단에 "Orchestrator" 탭 확인 (자동 로드됨)
```

**⚠️ 주의:** GDExtension은 자동 로드되므로 Project → Plugins에서 활성화할 필요 없습니다!

### 설치 확인

```
1. Godot 하단에 "Orchestrator" 탭이 나타나면 성공
2. 또는 노드에 스크립트 추가 시 "OrchestratorScript" 옵션 확인
```

---

## 5. 첫 번째 Orchestration 만들기

### 5.1 새 프로젝트 생성

```
1. Godot 실행
2. "New Project" 클릭
3. 프로젝트 이름 입력 (예: MyFirstOrchestration)
4. 프로젝트 경로 선택
5. Renderer: "Compatibility" 선택 (2D 게임용)
6. "Create & Edit" 클릭
```

### 5.2 씬 구성

```
1. Scene → New Scene
2. "2D Scene" 선택 (Node2D가 루트로 생성됨)
3. Node2D 선택 → 우클릭 → Add Child Node
4. "Sprite2D" 검색 후 추가
5. Sprite2D 선택 → Inspector → Texture
6. Texture 옆 드롭다운 → "Load" → Godot 아이콘 선택
   (또는 드래그앤드롭으로 이미지 추가)
7. Ctrl+S로 씬 저장 (예: main.tscn)
```

### 5.3 OrchestratorScript 연결

```
1. Sprite2D 노드 선택
2. Inspector 패널에서 Script 속성 찾기
3. Script 옆 드롭다운 → "New OrchestratorScript" 선택
4. 파일 이름 지정 (예: rotate.os)
5. "Create" 클릭
```

### 5.4 비주얼 스크립트 작성

Orchestrator 에디터가 자동으로 열립니다.

#### 목표: Sprite를 매 프레임 회전시키기

```
[_process 이벤트] ──→ [Rotate 함수]
       │                    │
   delta 값 ──────────→ 회전 속도
```

#### 단계별 가이드

```
1. 에디터 빈 공간에서 우클릭 → "Add Node" 메뉴 열기

2. Events 카테고리 → "_process" 선택
   - _process는 매 프레임마다 호출되는 이벤트
   - delta 파라미터: 이전 프레임과의 시간 차이

3. 다시 우클릭 → "Add Node"
   - Transform 카테고리 → "Rotate" 선택

4. 노드 연결:
   - _process 노드의 오른쪽 흰색 핀(실행 흐름)을
     Rotate 노드의 왼쪽 흰색 핀에 드래그하여 연결

5. 데이터 연결:
   - _process의 "delta" 출력 핀을
     Rotate의 "radians" 입력 핀에 연결

6. 회전 속도 조절 (선택):
   - Math → Multiply 노드 추가
   - delta * 2.0 으로 속도 2배로 설정
```

#### 완성된 그래프

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│   _process   │────→│   Multiply   │────→│    Rotate    │
│              │     │              │     │              │
│  delta ●────────→  │ A: delta     │     │ radians ●    │
│              │     │ B: 2.0       │     │              │
│              │     │ Result ●─────────→ │              │
└──────────────┘     └──────────────┘     └──────────────┘
```

### 5.5 실행 및 테스트

```
1. F5 키 또는 상단의 ▶ (Play) 버튼 클릭
2. 메인 씬 선택 창이 뜨면 "Select Current" 클릭
3. Godot 아이콘이 회전하는 것을 확인!
4. 창 닫기: X 버튼 또는 F8
```

### 5.6 저장

```
Ctrl+S: 현재 씬 저장
Ctrl+Shift+S: 모든 씬 저장
```

---

## 6. 핵심 개념

### 6.1 노드 타입

| 카테고리 | 설명 | 주요 노드 |
|----------|------|----------|
| **Events** | 게임 이벤트 트리거 | `_ready`, `_process`, `_input`, `_physics_process` |
| **Flow Control** | 로직 흐름 제어 | `Branch`, `For Loop`, `While Loop`, `Sequence`, `Switch` |
| **Math** | 수학 연산 | `Add`, `Subtract`, `Multiply`, `Divide`, `Random`, `Clamp` |
| **Variables** | 변수 관리 | `Get Variable`, `Set Variable`, `Local Variable` |
| **Functions** | 함수 호출 | `Call Function`, `Custom Function`, `Return` |
| **Signals** | 이벤트 시스템 | `Emit Signal`, `Connect Signal`, `Await Signal` |
| **Transform** | 위치/회전/크기 | `Rotate`, `Translate`, `Scale`, `Look At` |
| **Input** | 입력 처리 | `Is Action Pressed`, `Get Axis`, `Get Vector` |

### 6.2 핀(Pin) 타입

```
● 흰색 핀: 실행 흐름 (Execution Flow)
  - 노드가 실행되는 순서를 결정
  - 왼쪽: 입력 (이 노드가 실행됨)
  - 오른쪽: 출력 (다음 노드로 이동)

● 컬러 핀: 데이터 흐름 (Data Flow)
  - 값을 전달
  - 색상별 데이터 타입:
    - 파란색: Boolean
    - 초록색: Integer
    - 청록색: Float
    - 분홍색: String
    - 노란색: Vector2/Vector3
    - 빨간색: Object/Node
```

### 6.3 연결 규칙

```
[출력 핀] ──────────→ [입력 핀]

규칙:
1. 실행 핀은 실행 핀끼리만 연결
2. 데이터 핀은 같은 타입끼리 연결 (자동 변환되는 경우도 있음)
3. 하나의 출력은 여러 입력에 연결 가능
4. 하나의 입력은 하나의 출력만 받을 수 있음
```

### 6.4 주요 이벤트

| 이벤트 | 호출 시점 | 용도 |
|--------|----------|------|
| `_ready` | 노드가 씬에 추가될 때 (1회) | 초기화 |
| `_process(delta)` | 매 프레임 | 일반 로직, UI, 애니메이션 |
| `_physics_process(delta)` | 물리 프레임마다 (고정 간격) | 물리 연산, 이동 |
| `_input(event)` | 입력 이벤트 발생 시 | 키보드, 마우스 입력 |
| `_unhandled_input(event)` | 처리되지 않은 입력 | 게임 전역 입력 |

### 6.5 변수 사용

```
변수 생성:
1. Orchestrator 에디터 좌측 패널
2. "Variables" 섹션
3. "+" 버튼으로 새 변수 추가
4. 이름, 타입, 기본값 설정

변수 사용:
- Get Variable: 변수 값 읽기
- Set Variable: 변수 값 쓰기
```

---

## 7. 학습 리소스

### 공식 문서

| 문서 | 링크 | 설명 |
|------|------|------|
| **Introduction** | [링크](https://docs.cratercrash.space/orchestrator/getting-started/introduction/introduction-to-orchestrator/) | Orchestrator 소개 |
| **Step by Step** | [링크](https://docs.cratercrash.space/orchestrator/getting-started/step-by-step/) | 단계별 튜토리얼 |
| **Key Concepts** | [링크](https://docs.cratercrash.space/orchestrator/getting-started/introduction/key_concepts/) | 핵심 개념 |
| **전체 문서** | [링크](https://docs.cratercrash.space/orchestrator/) | 모든 문서 |

### 예제 프로젝트

```
GitHub: https://github.com/CraterCrash/godot-orchestrator-examples
```

실제 동작하는 예제를 다운로드하여 분석할 수 있습니다.

### 영상 튜토리얼

- [GameFromScratch - Orchestrator 소개](https://gamefromscratch.com/orchestrator-visual-scripting-for-godot/)

### 커뮤니티

| 플랫폼 | 용도 |
|--------|------|
| **Crater Crash Discord** | Orchestrator 전용 커뮤니티 |
| **Godot Discord** | #visual-scripting 채널 |
| **Godot Forum** | 질문 및 토론 |

### Godot 기초 학습 (추천)

Orchestrator를 효과적으로 사용하려면 Godot 기본 개념을 알면 좋습니다:

| 주제 | 설명 |
|------|------|
| **노드와 씬** | Godot의 기본 구조 |
| **시그널** | 이벤트 시스템 |
| **입력 처리** | Input Map, 액션 |
| **물리 엔진** | RigidBody, CollisionShape |

**Godot 공식 문서**: https://docs.godotengine.org/

---

## 8. 노코드 대안 비교

Orchestrator 외에 노코드 게임 개발 도구를 비교합니다.

### 비교표

| 항목 | Orchestrator | GDevelop | Construct 3 |
|------|-------------|----------|-------------|
| **타입** | Godot 플러그인 | 독립 엔진 | 독립 엔진 |
| **방식** | 노드 그래프 | 이벤트 시트 | 이벤트 시트 |
| **가격** | 무료 | 무료 (프리미엄 옵션) | $99/년 |
| **설치** | Godot 필요 | 앱/웹 | 웹 브라우저 |
| **학습 난이도** | 중간 | 쉬움 | 가장 쉬움 |
| **2D 지원** | ✅ | ✅ | ✅ |
| **3D 지원** | ✅ | 제한적 | ❌ |
| **성능** | 가장 좋음 | 중간 | 중간 |
| **확장성** | GDScript/C# | JavaScript | JavaScript |
| **오픈소스** | ✅ | ✅ | ❌ |

### GDevelop

**특징**: 완전 노코드, 오픈소스, 무료

**이벤트 시트 방식**:
```
┌─────────────────────────────────────────────────────┐
│ 조건 (Conditions)          │ 액션 (Actions)         │
├─────────────────────────────────────────────────────┤
│ 플레이어가 점프 키를 누름   │ 플레이어에 위쪽 힘 적용 │
│ AND 플레이어가 바닥에 있음  │ 점프 사운드 재생        │
└─────────────────────────────────────────────────────┘
```

**가격**:
- Free: 무료 (게임 출시 가능)
- Silver: €4.99/월
- Gold: €9.99/월

**링크**: https://gdevelop.io/

### Construct 3

**특징**: 브라우저 기반, 가장 직관적인 UI

**가격**:
- Free: 무료 (기능 제한)
- Personal: $99/년
- Business: $399/년

**링크**: https://www.construct.net/

### 추천 가이드

| 상황 | 추천 |
|------|------|
| 예산 없음 + 2D 캐주얼 게임 | GDevelop |
| 가장 쉬운 도구 원함 | Construct 3 |
| 3D도 하고 싶음 | Orchestrator + Godot |
| 나중에 코딩도 배우고 싶음 | Orchestrator + Godot |
| 성능이 중요함 | Orchestrator + Godot |

---

## 체크리스트

### 설치 체크리스트

```
□ Godot 4.5.x 다운로드
□ Godot 압축 해제 및 실행 확인
□ 새 프로젝트 생성
□ Orchestrator v2.3.x 설치 (Asset Library 또는 GitHub)
□ addons/orchestrator/orchestrator.gdextension 파일 존재 확인
□ 에디터 하단에 "Orchestrator" 탭 확인 (자동 로드됨)
```

**참고:** GDExtension은 자동 로드되므로 Project Settings → Plugins에서 활성화할 필요 없습니다!

### 학습 체크리스트

```
□ 첫 번째 Orchestration 생성 (회전 예제)
□ 공식 문서 Introduction 읽기
□ 공식 문서 Step by Step 완료
□ 예제 프로젝트 다운로드 및 분석
□ 변수, 함수, 시그널 개념 이해
□ 간단한 게임 프로토타입 만들기
```

### 프로젝트 아이디어 (난이도순)

```
1. [초급] 클릭하면 점프하는 캐릭터
2. [초급] 키보드로 이동하는 플레이어
3. [초중급] 적을 피하는 게임
4. [중급] 플랫포머 게임 (점프, 이동, 장애물)
5. [중급] 슈팅 게임 (총알 발사, 적 처치)
6. [중상급] 인벤토리 시스템
7. [상급] 대화 시스템이 있는 RPG
```

---

## 링크 모음

### Orchestrator

- **공식 사이트**: https://orchestrator.cratercrash.space/
- **GitHub**: https://github.com/CraterCrash/godot-orchestrator
- **문서**: https://docs.cratercrash.space/orchestrator/
- **예제**: https://github.com/CraterCrash/godot-orchestrator-examples
- **Asset Library**: https://godotengine.org/asset-library/asset/3209

### Godot

- **공식 사이트**: https://godotengine.org/
- **다운로드**: https://godotengine.org/download/windows/
- **문서**: https://docs.godotengine.org/
- **Asset Library**: https://godotengine.org/asset-library/

### 대안 도구

- **GDevelop**: https://gdevelop.io/
- **Construct 3**: https://www.construct.net/

---

## 문제 해결

### Orchestrator 탭이 보이지 않을 때

```
1. addons/orchestrator/orchestrator.gdextension 파일 존재 확인
2. Godot 재시작
3. 버전 호환성 확인 (Godot ↔ Orchestrator)
4. 에디터 하단 패널에서 "Orchestrator" 탭 찾기
```

**참고:** GDExtension은 자동 로드되므로 Project → Plugins에 표시되지 않습니다!

### ⚠️ "plugin.cfg 구문 분석 실패" 에러

**에러 메시지:**
```
다음 경로에 있는 애드온 플러그인을 활성화할 수 없음:
'res://addons/orchestrator/plugin.cfg' 구성의 구문 분석을 실패했습니다.
```

**원인:** `project.godot`에 잘못된 플러그인 설정이 있음

**해결:**
1. 텍스트 에디터로 `project.godot` 열기
2. `[editor_plugins]` 섹션에서 orchestrator 항목 제거:

```ini
:: 잘못된 설정 (제거해야 함)
[editor_plugins]
enabled=PackedStringArray("res://addons/orchestrator/plugin.cfg")

:: 올바른 설정
[editor_plugins]
enabled=PackedStringArray()
```

3. 저장 후 Godot 재시작

### 노드 연결이 안 될 때

```
1. 핀 타입 확인 (실행 핀 ↔ 실행 핀, 데이터 핀 ↔ 데이터 핀)
2. 데이터 타입 호환성 확인
3. 이미 연결된 입력 핀은 기존 연결 해제 후 재연결
```

### 게임이 실행되지 않을 때

```
1. 에러 메시지 확인 (하단 Output 패널)
2. 메인 씬이 설정되어 있는지 확인
3. OrchestratorScript가 제대로 저장되었는지 확인
```

---

**최종 업데이트**: 2026-01-24
