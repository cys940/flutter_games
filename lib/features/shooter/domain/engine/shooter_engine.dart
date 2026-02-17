import 'package:flame/game.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// 모든 플랫폼에서 공통으로 사요할 슈팅 게임 엔진 인터페이스입니다.
abstract class ShooterEngine extends Game {
  /// 게임 내 중요 수치(HP, Ammo 등)를 관리하는 Signals
  Signal<double> get healthSignal;
  Signal<int> get scoreSignal;

  /// 공통 명령
  void fireBullet();
  void reset();
}
