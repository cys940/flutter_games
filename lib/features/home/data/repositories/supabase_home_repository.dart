import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/game_entity.dart';
import '../../domain/repositories/home_repository.dart';

/// Supabase를 사용한 HomeRepository 구현체입니다.
@LazySingleton(as: HomeRepository)
class SupabaseHomeRepository implements HomeRepository {
  SupabaseHomeRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<List<GameEntity>> getGames() async {
    final response = await _client
        .from('games')
        .select()
        .order('created_at', ascending: true);

    return (response as List).map((json) => _mapToEntity(json)).toList();
  }

  @override
  Future<GameEntity> getGameById(String id) async {
    final response = await _client.from('games').select().eq('id', id).single();

    return _mapToEntity(response);
  }

  GameEntity _mapToEntity(Map<String, dynamic> json) {
    return GameEntity(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      score: json['score'] as int? ?? 0,
      thumbnailPath: json['thumbnail_path'] as String? ?? '',
      gameType: _parseGameType(json['game_type'] as String?),
      playCount: json['play_count'] as int? ?? 0,
      lastPlayed: json['last_played'] != null
          ? DateTime.tryParse(json['last_played'] as String)
          : null,
    );
  }

  GameType _parseGameType(String? type) {
    if (type == null) return GameType.other;
    return GameType.values.firstWhere(
      (e) => e.name == type.toLowerCase(),
      orElse: () => GameType.other,
    );
  }

  @override
  Future<void> saveScore({required String gameId, required int score}) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('User not authenticated.');
    }

    await _client.from('scores').insert({
      'user_id': userId,
      'game_id': gameId,
      'score': score,
    });
  }

  @override
  Future<List<Map<String, dynamic>>> fetchHighScores({
    required String gameId,
  }) async {
    final response = await _client
        .from('scores')
        .select('score, user_id') // Selecting score and user_id for now
        .eq('game_id', gameId)
        .order('score', ascending: false)
        .limit(10); // Top 10 high scores

    return (response as List)
        .map((json) => json as Map<String, dynamic>)
        .toList();
  }
}
