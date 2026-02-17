import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../../domain/engine/shooter_engine.dart';

Widget buildGameWidget(ShooterEngine engine) {
  return GameWidget(game: engine as FlameGame);
}
