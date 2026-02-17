import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import '../../../../core/engine/base_game_engine.dart';

/// 게임 내에서 클릭할 수 있는 간단한 개체 컴포넌트입니다.
class ScoreBoxComponent extends PositionComponent with TapCallbacks, HasGameReference<BaseGameEngine> {

  ScoreBoxComponent({
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size);
  static final _paint = Paint()..color = Colors.blue;

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }

  @override
  void onTapDown(TapDownEvent event) {
    // 클릭 시 베이스 엔진의 점수를 업데이트
    game.updateScore(10);
    
    // 시각적 피드백: 잠시 색상 변경
    _paint.color = Colors.orange;
    Future.delayed(const Duration(milliseconds: 100), () {
      _paint.color = Colors.blue;
    });
  }
}
