import '../entities/game_entity.dart';

/// Home 피처의 데이터 접근을 위한 추상 리포지토리 인터페이스입니다.
abstract class HomeRepository {
  Future<List<GameEntity>> getGames();
  Future<GameEntity> getGameById(String id);
}
