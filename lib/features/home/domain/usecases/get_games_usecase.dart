import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/game_entity.dart';
import '../repositories/home_repository.dart';

/// 게임 목록을 가져오는 유스케이스 구현입니다.
@injectable
class GetGamesUseCase implements UseCase<List<GameEntity>, NoParams> {
  const GetGamesUseCase(this.repository);
  final HomeRepository repository;

  @override
  Future<List<GameEntity>> call(NoParams params) async {
    return repository.getGames();
  }
}
