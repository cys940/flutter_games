/// 도메인 레이어의 핵심 게임 엔티티입니다.
///
/// 외부 라이브러리(built_value 등)에 의존하지 않는 순수 Dart 클래스로 작성합니다.
class GameEntity {

  const GameEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.score,
  });

  final String id;
  final String title;
  final String description;
  final int score;
}
