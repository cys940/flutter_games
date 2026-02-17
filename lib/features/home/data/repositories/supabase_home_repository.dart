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
    final response = await _client
        .from('games')
        .select()
        .eq('id', id)
        .single();
    
    return _mapToEntity(response);
  }

  GameEntity _mapToEntity(Map<String, dynamic> json) {
    return GameEntity(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      score: 0, // 점수 기능 구현 시 별도 조인 또는 쿼리 필요
    );
  }
}
