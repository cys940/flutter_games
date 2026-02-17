<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-02-07 | Updated: 2026-02-07 -->

# usecases

## Purpose
UseCase 패턴의 베이스 인터페이스. 모든 비즈니스 로직 유스케이스가 이 계약을 따른다.

## Key Files

| File | Description |
|------|-------------|
| `usecase.dart` | `UseCase<Type, Params>` 인터페이스 (`call()` 메서드), `NoParams` 클래스 |

## For AI Agents

### Working In This Directory
- 새 유스케이스는 `UseCase<ReturnType, ParamsType>`를 구현
- 파라미터 없는 유스케이스는 `NoParams` 사용
- 유스케이스는 domain 레이어에 위치 (feature별 `domain/usecases/`)

<!-- MANUAL: -->
