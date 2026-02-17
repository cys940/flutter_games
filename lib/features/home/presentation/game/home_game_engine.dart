import 'package:flame/game.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/engine/base_game_engine.dart';
import 'score_box_component.dart';

/// Home 피처 전용 게임 엔진 구현체입니다.
@injectable
class HomeGameEngine extends BaseGameEngine {
  @override
  Future<void> onLoad() async {
    // 게임월드에 컴포넌트 추가
    add(
      ScoreBoxComponent(
        position: Vector2(100, 100),
        size: Vector2(80, 80),
      ),
    );
  }
}
