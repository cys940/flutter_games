import '../../domain/engine/shooter_engine.dart';
import 'web/shooter_game_engine_2d.dart';

/// Web 및 미지원 플랫폼을 위한 엔진 생성 함수입니다.
ShooterEngine createEngine() => ShooterEngineWeb();
