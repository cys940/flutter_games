import 'package:injectable/injectable.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/game_entity.dart';
import '../../domain/usecases/get_games_usecase.dart';
import '../game/home_game_engine.dart';

/// Home 화면의 상태와 로직을 관리하는 ViewModel 클래스입니다.
@injectable
class HomeViewModel {

  HomeViewModel(this._getGamesUseCase, this.gameEngine);
  final GetGamesUseCase _getGamesUseCase;
  
  /// Flame 게임 엔진 인스턴스
  final HomeGameEngine gameEngine;

  /// 게임 목록 상태 선언
  late final games = signal<List<GameEntity>>([]);
  
  /// 엔진의 점수 Signal을 ViewModel에서도 동일하게 사용 (computed shorthand 활용 가능)
  late final totalScore = gameEngine.scoreSignal;
  
  /// 로딩 상태 선언
  late final isLoading = signal<bool>(false);

  /// 에러 메시지 상태 선언
  late final errorMessage = signal<String?>(null);

  /// 비즈니스 로직: 게임 목록 가져오기
  Future<void> fetchGames() async {
    isLoading.value = true;
    errorMessage.value = null;
    
    try {
      final result = await _getGamesUseCase(const NoParams());
      games.value = result;
    } catch (e) {
      errorMessage.value = '게임 데이터를 불러오지 못했습니다: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }
}
