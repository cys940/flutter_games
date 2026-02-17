<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-02-07 | Updated: 2026-02-07 -->

# data

## Purpose
Home feature의 데이터 레이어. 직렬화 가능한 모델과 리포지토리 구현을 포함한다.

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `models/` | built_value 기반 데이터 모델 |
| `repositories/` | 리포지토리 인터페이스의 구체적 구현 |

## Key Files (in subdirectories)

| File | Description |
|------|-------------|
| `models/game_model.dart` | built_value 직렬화 가능 게임 모델 |
| `models/game_model.g.dart` | **자동 생성** — 수정 금지 |
| `repositories/mock_home_repository.dart` | 하드코딩 데이터를 반환하는 Mock 구현 |

## For AI Agents

### Working In This Directory
- built_value 모델 수정 후 `dart run build_runner build --delete-conflicting-outputs` 실행
- `*.g.dart` 파일은 절대 직접 수정하지 말 것
- 새 리포지토리 구현 시 `@LazySingleton(as: HomeRepository)` 어노테이션 사용

<!-- MANUAL: -->