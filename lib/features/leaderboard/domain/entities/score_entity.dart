class ScoreEntity {
  const ScoreEntity({
    required this.id,
    required this.userId,
    required this.username,
    this.avatarUrl,
    required this.gameId,
    required this.score,
    required this.createdAt,
  });

  final String id;
  final String userId;
  final String username;
  final String? avatarUrl;
  final String gameId;
  final int score;
  final DateTime createdAt;
}
