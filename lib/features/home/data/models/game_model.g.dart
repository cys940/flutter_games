// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GameModel> _$gameModelSerializer = _$GameModelSerializer();

class _$GameModelSerializer implements StructuredSerializer<GameModel> {
  @override
  final Iterable<Type> types = const [GameModel, _$GameModel];
  @override
  final String wireName = 'GameModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GameModel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      ),
      'description',
      serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      ),
      'score',
      serializers.serialize(object.score, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GameModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GameModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'title':
          result.title =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'description':
          result.description =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'score':
          result.score =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GameModel extends GameModel {
  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final int score;

  factory _$GameModel([void Function(GameModelBuilder)? updates]) =>
      (GameModelBuilder()..update(updates))._build();

  _$GameModel._({
    required this.id,
    required this.title,
    required this.description,
    required this.score,
  }) : super._();
  @override
  GameModel rebuild(void Function(GameModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GameModelBuilder toBuilder() => GameModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GameModel &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
        score == other.score;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, score.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GameModel')
          ..add('id', id)
          ..add('title', title)
          ..add('description', description)
          ..add('score', score))
        .toString();
  }
}

class GameModelBuilder implements Builder<GameModel, GameModelBuilder> {
  _$GameModel? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  int? _score;
  int? get score => _$this._score;
  set score(int? score) => _$this._score = score;

  GameModelBuilder();

  GameModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _description = $v.description;
      _score = $v.score;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GameModel other) {
    _$v = other as _$GameModel;
  }

  @override
  void update(void Function(GameModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GameModel build() => _build();

  _$GameModel _build() {
    final _$result =
        _$v ??
        _$GameModel._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'GameModel', 'id'),
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'GameModel',
            'title',
          ),
          description: BuiltValueNullFieldError.checkNotNull(
            description,
            r'GameModel',
            'description',
          ),
          score: BuiltValueNullFieldError.checkNotNull(
            score,
            r'GameModel',
            'score',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
