import '../../domain/engine/shooter_engine.dart';
import 'native/shooter_game_engine_3d.dart';

/// Native(iOS, Android, macOS, Windows, Linux)를 위한 엔진 생성 함수입니다.
ShooterEngine createEngine() => ShooterEngineNative();
