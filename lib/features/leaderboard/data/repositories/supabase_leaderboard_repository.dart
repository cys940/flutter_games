import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/score_entity.dart';
import '../../domain/repositories/leaderboard_repository.dart';

@LazySingleton(as: LeaderboardRepository)
class SupabaseLeaderboardRepository implements LeaderboardRepository {
  SupabaseLeaderboardRepository(this._supabase);
  final SupabaseClient _supabase;

  @override
  Future<List<ScoreEntity>> getTopScores({String? gameId, int limit = 50}) async {
    // eq() must come before order() and limit() in postgrest
    dynamic query = _supabase
        .from('scores')
        .select('*, profiles(username, avatar_url)');

    if (gameId != null && gameId.isNotEmpty) {
      query = (query as dynamic).eq('game_id', gameId);
    }

    final data = await (query as dynamic)
        .order('score', ascending: false)
        .limit(limit);

    return (data as List).map((row) {
      final profile = row['profiles'] as Map<String, dynamic>? ?? {};
      return ScoreEntity(
        id: row['id'] as String,
        userId: row['user_id'] as String,
        username: (profile['username'] as String?) ?? '익명',
        avatarUrl: profile['avatar_url'] as String?,
        gameId: row['game_id'] as String,
        score: row['score'] as int,
        createdAt: DateTime.parse(row['created_at'] as String),
      );
    }).toList();
  }

  @override
  Future<List<ScoreEntity>> getMyScores(String userId) async {
    final data = await _supabase
        .from('scores')
        .select('*, profiles(username, avatar_url)')
        .eq('user_id', userId)
        .order('score', ascending: false)
        .limit(20);

    return (data as List).map((row) {
      final profile = row['profiles'] as Map<String, dynamic>? ?? {};
      return ScoreEntity(
        id: row['id'] as String,
        userId: row['user_id'] as String,
        username: (profile['username'] as String?) ?? '익명',
        avatarUrl: profile['avatar_url'] as String?,
        gameId: row['game_id'] as String,
        score: row['score'] as int,
        createdAt: DateTime.parse(row['created_at'] as String),
      );
    }).toList();
  }

  @override
  Future<void> submitScore({
    required String userId,
    required String gameId,
    required int score,
  }) async {
    await _supabase.from('scores').insert({
      'user_id': userId,
      'game_id': gameId,
      'score': score,
    });
  }
}
