import '../entities/score_entity.dart';

abstract class LeaderboardRepository {
  Future<List<ScoreEntity>> getTopScores({String? gameId, int limit = 50});
  Future<List<ScoreEntity>> getMyScores(String userId);
  Future<void> submitScore({required String userId, required String gameId, required int score});
}
