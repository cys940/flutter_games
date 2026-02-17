import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../../domain/engine/shooter_engine.dart';

Widget buildGameWidget(ShooterEngine engine) {
  // engine이 ShooterEngineNative임을 보장 (조건부 임포트 상황)
  return GameWidget(game: engine as FlameGame);
}
