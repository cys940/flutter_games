// import 'package:injectable/injectable.dart';
import '../../domain/entities/game_entity.dart';
import '../../domain/repositories/home_repository.dart';

/// 테스트를 위한 HomeRepository 목업 구현체입니다.
// @LazySingleton(as: HomeRepository)
class MockHomeRepository implements HomeRepository {
  @override
  Future<List<GameEntity>> getGames() async {
    // 실제 서버 통신을 흉내내는 딜레이
    await Future.delayed(const Duration(seconds: 1));
    return [
      const GameEntity(id: '1', title: 'Super Dash', description: 'Exciting runner game', score: 100),
      const GameEntity(id: 'shooter', title: '3D Shooter', description: 'Experience high-quality 3D shooting', score: 0),
      const GameEntity(id: '3', title: 'Tic Tac Toe', description: 'Classic and fun', score: 80),
    ];
  }

  @override
  Future<GameEntity> getGameById(String id) async {
    return const GameEntity(id: '1', title: 'Super Dash', description: 'Exciting runner game', score: 100);
  }
}
