import 'package:flame/game.dart';
import 'package:signals_flutter/signals_core.dart';

/// 앱 전체에서 공통으로 사용할 수 있는 Flame 게임 엔진 베이스 클래스입니다.
///
/// Signals를 연동하여 외부에 게임 상태를 알 수 있게 설계합니다.
abstract class BaseGameEngine extends FlameGame {
  /// 게임 엔진에서의 점수 Signal
  final scoreSignal = signal<int>(0);

  // onMount 오버라이드 제거

  /// 점수를 업데이트하는 핵심 메서드
  void updateScore(int delta) {
    scoreSignal.value += delta;
  }
}
