<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-02-07 | Updated: 2026-02-07 -->

# widgets

## Purpose
앱 전체에서 공유되는 게임 테마 UI 위젯 컬렉션.

## Key Files

| File | Description |
|------|-------------|
| `game_glass_card.dart` | 글라스모피즘 카드 (backdrop blur 효과) |
| `game_score_board.dart` | 네온 글로우 스타일 스코어보드 |
| `game_status_tag.dart` | 상태 배지 (LIVE, ACTIVE 등) |
| `game_gauge.dart` | 애니메이션 프로그레스 바 (HP/Ammo 표시) |

## For AI Agents

### Working In This Directory
- `AppColors`와 `AppTypography`를 사용하여 사이버 테마 일관성 유지
- 새 위젯은 `Game` 접두사 네이밍 컨벤션 따를 것
- 위젯은 가능한 stateless로 구현, 상태는 Signal로 외부에서 전달

<!-- MANUAL: -->