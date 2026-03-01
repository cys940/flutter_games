import 'package:flame/game.dart';
import 'package:signals_flutter/signals_flutter.dart';
import '../../../domain/engine/shooter_engine.dart';

/// 웹(Chrome) 또는 3D 미지원 플랫폼을 위한 2D 슈팅 게임 엔진 스터브입니다.
class ShooterEngineWeb extends FlameGame implements ShooterEngine {
  @override
  final healthSignal = signal<double>(100.0);

  @override
  final scoreSignal = signal<int>(0);

  @override
  Future<void> onLoad() async {
    // 웹에서는 2D 안내 메시지 또는 간단한 2D 게임 렌더링
  }

  @override
  void fireBullet() {
    // 2D 총알 발사 로직 (생략 가능)
    scoreSignal.value += 10;
  }

  @override
  void reset() {
    healthSignal.value = 100.0;
    scoreSignal.value = 0;
  }
}
