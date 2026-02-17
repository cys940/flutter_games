<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-02-07 | Updated: 2026-02-07 -->

# domain

## Purpose
Shooter feature의 도메인 레이어. 게임 엔진 추상 인터페이스를 정의하며, 엔티티/리포지토리/유스케이스 디렉토리는 확장을 위해 준비되어 있다.

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `engine/` | 슈터 엔진 추상 인터페이스 |
| `entities/` | 게임 엔티티 (비어있음 — 무기, 적, 파워업 추가 가능) |
| `repositories/` | 리포지토리 인터페이스 (비어있음 — 리더보드, 세이브 추가 가능) |
| `usecases/` | 유스케이스 (비어있음 — 게임 로직 추가 가능) |

## Key Files

| File | Description |
|------|-------------|
| `engine/shooter_engine.dart` | `ShooterEngine` 추상 클래스 — health/score Signal, fire/reset 메서드 |

## For AI Agents

### Working In This Directory
- `ShooterEngine`은 추상 클래스 — 구현은 presentation/game/에서
- 새 게임 메커닉 추가 시 여기에 인터페이스 정의 → presentation에서 구현

<!-- MANUAL: -->