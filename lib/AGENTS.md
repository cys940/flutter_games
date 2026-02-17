<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-02-07 | Updated: 2026-02-07 -->

# lib

## Purpose
애플리케이션의 전체 Dart 소스 코드. Clean Architecture 기반으로 core(공통 인프라)와 features(기능별 모듈)로 나뉜다.

## Key Files

| File | Description |
|------|-------------|
| `main.dart` | 앱 진입점 — WidgetsFlutterBinding 초기화, DI 설정, MaterialApp + GoRouter 구성 |

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `core/` | 공통 인프라 (DI, 디자인 시스템, 엔진, 에러, 라우터 등) (see `core/AGENTS.md`) |
| `features/` | 기능별 모듈 (home, shooter) (see `features/AGENTS.md`) |

## For AI Agents

### Working In This Directory
- `main.dart`는 최소한의 부트스트랩 코드만 유지할 것
- 새 기능은 반드시 `features/` 하위에 clean architecture 구조로 추가
- 공통 코드는 `core/`에 배치

### Common Patterns
- Feature-based 디렉토리 구조
- 각 feature는 data/domain/presentation 3개 레이어
- ViewModel은 Signals로 상태 관리
- DI는 GetIt + Injectable 어노테이션

## Dependencies

### Internal
- `core/di/injection.dart` — DI 초기화
- `core/router/app_router.dart` — 라우팅

<!-- MANUAL: -->