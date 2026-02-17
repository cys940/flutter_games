<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-02-07 | Updated: 2026-02-07 -->

# shooter

## Purpose
3D FPS 슈터 게임 feature. 웨이브 기반 적 처치 시스템, 플랫폼별 렌더링(네이티브 3D / 웹 2D 폴백), HUD 오버레이를 제공한다.

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `data/` | 데이터 모델 및 리포지토리 (현재 비어있음 — 확장 준비) |
| `domain/` | 게임 엔진 인터페이스, 엔티티, 유스케이스 (see `domain/AGENTS.md`) |
| `presentation/` | 게임 페이지, ViewModel, 플랫폼별 엔진 (see `presentation/AGENTS.md`) |

## For AI Agents

### Working In This Directory
- 플랫폼별 렌더링 분기: `dart.library.io` 조건부 임포트 패턴
- 네이티브: flame_3d (3D), 웹: flame (2D 폴백)
- data/ 하위 디렉토리가 비어있음 — 리더보드, 세이브 데이터 등 확장 가능
- domain/entities/, domain/repositories/, domain/usecases/도 비어있음 — 무기, 적, 파워업 엔티티 추가 가능

<!-- MANUAL: -->