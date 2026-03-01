import 'package:injectable/injectable.dart';
import '../../domain/engine/shooter_engine.dart';

/// 슈팅 게임의 상태를 관리하는 ViewModel입니다.
@injectable
class ShooterViewModel {
  ShooterViewModel(this.gameEngine);
  final ShooterEngine gameEngine;

  /// 엔진의 Signals 연결
  late final health = gameEngine.healthSignal;
  late final score = gameEngine.scoreSignal;

  /// 게임 명령 전달
  void fire() {
    gameEngine.fireBullet();
  }

  void resetGame() {
    health.value = 100.0;
    score.value = 0;
  }
}
