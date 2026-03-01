# Task T2: Refactor GameEntity metadata - Result

**Goal**: Add metadata fields to `GameEntity` to support a richer dashboard.

**Outcome**:
The `GameEntity` in `lib/features/home/domain/entities/game_entity.dart` has been successfully refactored.

**Changes Details**:
- A `GameType` enum was introduced to categorize games.
- The `GameEntity` class now includes the following new fields:
    - `thumbnailPath` (String)
    - `gameType` (GameType)
    - `playCount` (int)
    - `lastPlayed` (DateTime?, nullable)
- The constructor was updated to include these new fields.
- A `copyWith` method was implemented for convenient object manipulation while maintaining immutability.
- The `operator ==` and `hashCode` methods were manually overridden to ensure proper object comparison and hashing, adhering to the "pure Dart class" requirement.

**Code Snippet (`lib/features/home/domain/entities/game_entity.dart`)**:

```dart
/// 도메인 레이어의 핵심 게임 엔티티입니다.
///
/// 외부 라이브러리(built_value 등)에 의존하지 않는 순수 Dart 클래스로 작성합니다.
enum GameType {
  shooter,
  racing,
  puzzle,
  adventure,
  platformer,
  rpg,
  strategy,
  simulation,
  sports,
  fighting,
  survival,
  horror,
  rhythm,
  party,
  educational,
  other,
}

class GameEntity {
  const GameEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.score,
    required this.thumbnailPath,
    required this.gameType,
    required this.playCount,
    this.lastPlayed,
  });

  final String id;
  final String title;
  final String description;
  final int score;
  final String thumbnailPath;
  final GameType gameType;
  final int playCount;
  final DateTime? lastPlayed;

  GameEntity copyWith({
    String? id,
    String? title,
    String? description,
    int? score,
    String? thumbnailPath,
    GameType? gameType,
    int? playCount,
    DateTime? lastPlayed,
  }) {
    return GameEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      score: score ?? this.score,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      gameType: gameType ?? this.gameType,
      playCount: playCount ?? this.playCount,
      lastPlayed: lastPlayed ?? this.lastPlayed,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GameEntity &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.score == score &&
        other.thumbnailPath == thumbnailPath &&
        other.gameType == gameType &&
        other.playCount == playCount &&
        other.lastPlayed == lastPlayed;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        score.hashCode ^
        thumbnailPath.hashCode ^
        gameType.hashCode ^
        playCount.hashCode ^
        lastPlayed.hashCode;
  }
}
```
