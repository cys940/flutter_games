<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-02-07 | Updated: 2026-02-07 -->

# router

## Purpose
GoRouter 기반 앱 네비게이션 설정. 모든 라우트를 중앙에서 관리한다.

## Key Files

| File | Description |
|------|-------------|
| `app_router.dart` | 라우트 정의 — `/` (HomePage), `/shooter` (ShooterPage) |

## For AI Agents

### Working In This Directory
- 새 feature 추가 시 이 파일에 라우트 등록
- `context.push()` / `context.pop()`으로 네비게이션
- ViewModel은 라우트 빌더에서 `getIt<T>()`로 주입

<!-- MANUAL: -->
