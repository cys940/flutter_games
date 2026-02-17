<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-02-07 | Updated: 2026-02-07 -->

# engine

## Purpose
Flame 게임 엔진의 베이스 클래스. 2D와 3D 게임의 공통 인터페이스(점수, 체력 Signal 통합)를 제공한다.

## Key Files

| File | Description |
|------|-------------|
| `base_game_engine.dart` | 2D Flame 게임 베이스 — `scoreSignal` 통합 |
| `native_base_engine_3d.dart` | 3D Flame 게임 베이스 — `healthSignal`, `scoreSignal` 통합 |

## For AI Agents

### Working In This Directory
- 새 게임 타입 추가 시 적절한 베이스 클래스를 상속
- Signal을 통해 게임 상태를 Flutter UI에 전파
- `update()` 메서드는 60FPS로 호출되므로 가볍게 유지

<!-- MANUAL: -->