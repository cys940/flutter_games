import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'game_model.g.dart';

/// built_value를 사용한 게임 데이터 모델의 예시입니다.
abstract class GameModel implements Built<GameModel, GameModelBuilder> {
  factory GameModel([void Function(GameModelBuilder) updates]) = _$GameModel;

  GameModel._();
  String get id;
  String get title;
  String get description;
  int get score;

  static Serializer<GameModel> get serializer => _$gameModelSerializer;
}
