<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-02-07 | Updated: 2026-02-07 -->

# di

## Purpose
GetIt + Injectable 기반 의존성 주입 설정. 앱 전체의 서비스 등록과 플랫폼별 엔진 프로비저닝을 담당한다.

## Key Files

| File | Description |
|------|-------------|
| `injection.dart` | GetIt 설정 진입점 (`configureDependencies()`) |
| `injection.config.dart` | **자동 생성** — Injectable이 생성하는 DI 설정 (수정 금지) |
| `engine_module.dart` | 플랫폼별 게임 엔진을 제공하는 Injectable 모듈 |

## For AI Agents

### Working In This Directory
- `injection.config.dart`는 절대 직접 수정하지 말 것
- 새 서비스 등록 후 반드시 `dart run build_runner build --delete-conflicting-outputs` 실행
- 플랫폼별 의존성은 `engine_module.dart`처럼 `@module`로 제공

### Common Patterns
- `@injectable` — 일반 의존성
- `@lazySingleton` — 지연 싱글톤
- `@LazySingleton(as: AbstractRepo)` — 인터페이스 바인딩
- `@module` — 외부 또는 플랫폼 의존성 제공

<!-- MANUAL: -->