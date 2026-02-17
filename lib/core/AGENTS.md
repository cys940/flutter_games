<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-02-07 | Updated: 2026-02-07 -->

# core

## Purpose
전체 앱에서 공유되는 인프라 코드. 의존성 주입, 디자인 시스템, 게임 엔진 베이스, 에러 처리, 레이아웃, 공통 위젯, 라우터, UseCase 인터페이스를 포함한다.

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `di/` | GetIt + Injectable 기반 의존성 주입 설정 (see `di/AGENTS.md`) |
| `design_system/` | 색상, 타이포그래피 등 디자인 토큰 (see `design_system/AGENTS.md`) |
| `engine/` | Flame 2D/3D 게임 엔진 베이스 클래스 (see `engine/AGENTS.md`) |
| `error/` | 커스텀 예외 계층 구조 (see `error/AGENTS.md`) |
| `layouts/` | 반응형 레이아웃 유틸리티 (see `layouts/AGENTS.md`) |
| `presentation/` | 공통 UI 위젯 (see `presentation/AGENTS.md`) |
| `router/` | GoRouter 네비게이션 설정 (see `router/AGENTS.md`) |
| `usecases/` | UseCase 베이스 인터페이스 (see `usecases/AGENTS.md`) |

## For AI Agents

### Working In This Directory
- core는 feature에 의존하면 안 됨 (단방향 의존성)
- 새 공통 컴포넌트 추가 시 적절한 하위 디렉토리에 배치
- DI 관련 변경 후 `dart run build_runner build --delete-conflicting-outputs` 실행

### Common Patterns
- 싱글톤 서비스는 `@lazySingleton` 어노테이션
- 베이스 클래스는 abstract로 선언하고 feature에서 구현

<!-- MANUAL: -->