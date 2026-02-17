<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-02-07 | Updated: 2026-02-07 -->

# features

## Purpose
기능별 모듈 디렉토리. 각 feature는 Clean Architecture(data/domain/presentation)를 따르며 독립적으로 동작한다.

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `home/` | 홈 화면 — 게임 목록, 2D 인터랙티브 데모 (see `home/AGENTS.md`) |
| `shooter/` | 3D FPS 슈터 게임 — 웨이브 기반 적 처치 (see `shooter/AGENTS.md`) |

## For AI Agents

### Working In This Directory
- 새 feature 추가 시 반드시 `{feature}/data/`, `{feature}/domain/`, `{feature}/presentation/` 구조 생성
- feature 간 직접 의존 금지 — 공통 코드는 `core/`로 올릴 것
- 새 feature의 라우트는 `core/router/app_router.dart`에 등록

### Common Patterns
```
features/
  {feature_name}/
    ├── data/          # 모델, 리포지토리 구현
    ├── domain/        # 엔티티, 리포지토리 인터페이스, 유스케이스
    └── presentation/  # 페이지, ViewModel, 위젯, 게임 엔진
```

<!-- MANUAL: -->