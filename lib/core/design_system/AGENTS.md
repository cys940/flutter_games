<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-02-07 | Updated: 2026-02-07 -->

# design_system

## Purpose
앱 전체의 디자인 토큰 정의. 사이버/네온 테마의 색상 팔레트와 Google Fonts 기반 타이포그래피를 제공한다.

## Key Files

| File | Description |
|------|-------------|
| `styles.dart` | `AppColors` (딥 미드나잇 + 네온 글로우), `AppTypography` (Orbitron, Inter, Share Tech Mono) |

## For AI Agents

### Working In This Directory
- 새 색상/스타일 추가 시 기존 사이버 테마와 일관성 유지
- 색상은 `AppColors` 상수로, 텍스트 스타일은 `AppTypography`로 접근
- 하드코딩된 색상/폰트 사용 금지

<!-- MANUAL: -->