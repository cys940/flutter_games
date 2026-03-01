import 'package:flame/events.dart';
import 'package:flame_3d/game.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// 앱 전체에서 공통으로 사용할 수 있는 Flame 3D 게임 엔진 베이스 클래스입니다.
///
/// Signals를 연동하여 게임 내 3D 상태를 Flutter UI와 동계화합니다.
abstract class BaseGameEngine3D extends FlameGame3D
    with HasKeyboardHandlerComponents {
  /// 게임 내 중요 수치(HP, Ammo 등)를 관리하는 Signals
  final Signal<double> healthSignal = signal<double>(100.0);
  final Signal<int> scoreSignal = signal<int>(0);

  // onMount 오버라이드 제거

  /// 상태 업데이트를 위한 헬퍼 메서드
  void updateHealth(double delta) {
    healthSignal.value = (healthSignal.value + delta).clamp(0.0, 100.0);
  }

  void addScore(int delta) {
    scoreSignal.value += delta;
  }
}
