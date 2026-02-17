<!-- Generated: 2026-02-07 | Updated: 2026-02-07 -->

# game

## Purpose
Flutter 기반 게임 애플리케이션으로, Clean Architecture 패턴을 적용한 2D/3D 게임 프로젝트. Flame 엔진을 활용하며 네이티브 플랫폼에서는 3D, 웹에서는 2D 폴백을 제공한다.

## Key Files

| File | Description |
|------|-------------|
| `pubspec.yaml` | 프로젝트 의존성 및 스크립트 설정 |
| `analysis_options.yaml` | 98개 린트 규칙이 포함된 엄격한 코드 품질 설정 |
| `lib/main.dart` | 앱 진입점 (DI 초기화, 테마, GoRouter 설정) |
| `.gitignore` | Git 추적 제외 파일 설정 |

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `lib/` | 애플리케이션 소스 코드 (see `lib/AGENTS.md`) |
| `assets/` | 이미지, 오디오, 3D 모델 에셋 (see `assets/AGENTS.md`) |
| `test/` | 테스트 스위트 (see `test/AGENTS.md`) |
| `android/` | Android 플랫폼 설정 |
| `ios/` | iOS 플랫폼 설정 |
| `web/` | Web 플랫폼 설정 |
| `macos/` | macOS 플랫폼 설정 |
| `linux/` | Linux 플랫폼 설정 |
| `windows/` | Windows 플랫폼 설정 |

## For AI Agents

### Working In This Directory
- `pubspec.yaml` 수정 후 반드시 `flutter pub get` 실행
- 생성 파일(`*.g.dart`, `*.config.dart`)은 절대 직접 수정하지 말 것
- 코드 생성 필요 시: `dart run build_runner build --delete-conflicting-outputs`
- TypeScript가 아닌 **Dart** 프로젝트임을 주의

### Testing Requirements
- `flutter test` 로 테스트 실행
- `flutter analyze` 로 린트 검사
- 현재 테스트 커버리지가 매우 낮음 — 새 기능 추가 시 테스트 작성 권장

### Common Patterns
- **Clean Architecture**: data / domain / presentation 레이어 분리
- **Signals**: 반응형 상태 관리 (`signals_flutter`)
- **GetIt + Injectable**: 의존성 주입
- **GoRouter**: 선언적 라우팅
- **Flame Engine**: 2D/3D 게임 엔진
- **built_value**: 불변 데이터 모델

## Dependencies

### External
- Flutter SDK (Dart >=3.10.8)
- Flame ^1.18.0 / flame_3d ^0.1.0-release.0
- signals_flutter ^6.3.0
- get_it ^7.7.0 / injectable ^2.4.2
- go_router ^14.7.2
- google_fonts ^6.2.1
- built_value ^8.9.3

<!-- MANUAL: -->
