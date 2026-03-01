import 'package:flutter/material.dart';
import '../../domain/engine/shooter_engine.dart';

// 조건부 임포트 사용
import 'web/shooter_widget_web.dart'
    if (dart.library.io) 'native/shooter_widget_native.dart';

/// 플랫폼에 따라 GameWidget3D 또는 GameWidget(2D)를 반환하는 위젯입니다.
class ShooterGameWidget extends StatelessWidget {
  const ShooterGameWidget({super.key, required this.engine});
  final ShooterEngine engine;

  @override
  Widget build(BuildContext context) {
    return buildGameWidget(engine);
  }
}
