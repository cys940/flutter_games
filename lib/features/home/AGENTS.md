<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-02-07 | Updated: 2026-02-07 -->

# home

## Purpose
홈 화면 feature. 게임 목록을 표시하고 2D 인터랙티브 Flame 엔진 데모를 제공한다. Clean Architecture(data/domain/presentation) 구조.

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `data/` | 데이터 모델 및 리포지토리 구현 (see `data/AGENTS.md`) |
| `domain/` | 엔티티, 리포지토리 인터페이스, 유스케이스 (see `domain/AGENTS.md`) |
| `presentation/` | 페이지, ViewModel, 게임 엔진, 위젯 (see `presentation/AGENTS.md`) |

## For AI Agents

### Working In This Directory
- 레이어 간 의존성 방향: presentation → domain ← data
- domain 레이어는 다른 레이어에 의존하면 안 됨
- 현재 Mock 리포지토리 사용 중 — 실제 API 연동 시 data 레이어만 변경

<!-- MANUAL: -->