<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-02-07 | Updated: 2026-02-07 -->

# error

## Purpose
커스텀 예외 계층 구조. 서버/클라이언트/Not Found 등 비즈니스 로직에 맞는 예외를 정의한다.

## Key Files

| File | Description |
|------|-------------|
| `app_exception.dart` | `AppException`(base), `ServerException`, `ClientException`, `NotFoundException` |

## For AI Agents

### Working In This Directory
- 새 예외 타입 추가 시 `AppException`을 상속
- ViewModel에서 예외를 잡아 `errorMessage` Signal로 UI에 전달

<!-- MANUAL: -->