import 'package:injectable/injectable.dart';
import '../../features/shooter/domain/engine/shooter_engine.dart';
import '../../features/shooter/presentation/game/shooter_engine_factory.dart';

@module
abstract class EngineModule {
  @lazySingleton
  ShooterEngine get shooterEngine => ShooterEngineProvider.provide();
}
