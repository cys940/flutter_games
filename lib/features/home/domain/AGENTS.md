<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-02-07 | Updated: 2026-02-07 -->

# domain

## Purpose
Home feature의 도메인 레이어. 순수 Dart 엔티티, 리포지토리 인터페이스, 비즈니스 로직 유스케이스를 정의한다.

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `entities/` | 순수 Dart 불변 엔티티 |
| `repositories/` | 추상 리포지토리 인터페이스 |
| `usecases/` | 비즈니스 로직 유스케이스 |

## Key Files (in subdirectories)

| File | Description |
|------|-------------|
| `entities/game_entity.dart` | `GameEntity` — id, title, description, score |
| `repositories/home_repository.dart` | `HomeRepository` 추상 인터페이스 |
| `usecases/get_games_usecase.dart` | 게임 목록 조회 유스케이스 |

## For AI Agents

### Working In This Directory
- 이 레이어는 Flutter/패키지 의존성을 가지면 안 됨 (순수 Dart)
- 엔티티는 불변(immutable)으로 유지
- 유스케이스는 `UseCase<Type, Params>` 인터페이스 구현

<!-- MANUAL: -->