<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-02-07 | Updated: 2026-02-07 -->

# presentation

## Purpose
Home feature의 프레젠테이션 레이어. 메인 홈 페이지, Signals 기반 ViewModel, 2D Flame 게임 엔진, UI 위젯을 포함한다.

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `pages/` | 홈 페이지 (게임 목록 + Flame 프리뷰) |
| `viewmodels/` | Signals 기반 상태 관리 ViewModel |
| `game/` | 2D Flame 인터랙티브 데모 엔진 |
| `widgets/` | Home 전용 위젯 (현재 비어있음) |

## Key Files (in subdirectories)

| File | Description |
|------|-------------|
| `pages/home_page.dart` | 메인 홈 화면 — Flame 프리뷰, 게임 그리드, 애니메이션 배경 |
| `viewmodels/home_view_model.dart` | `games`, `isLoading`, `errorMessage`, `totalScore` Signal |
| `game/home_game_engine.dart` | `ScoreBoxComponent`가 포함된 2D Flame 엔진 |
| `game/score_box_component.dart` | 클릭하면 점수 올라가는 인터랙티브 2D 박스 |

## For AI Agents

### Working In This Directory
- ViewModel은 `getIt<HomeViewModel>()`으로 접근
- UI 상태는 `Watch((context) => ...)` 위젯으로 반응형 렌더링
- 비즈니스 로직은 ViewModel 또는 UseCase에 — 페이지에 직접 넣지 말 것
- `setState` 사용 금지 — Signal 사용

<!-- MANUAL: -->