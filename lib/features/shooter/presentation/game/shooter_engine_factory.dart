import '../../domain/engine/shooter_engine.dart';
import 'shooter_engine_web.dart'
    if (dart.library.io) 'shooter_engine_native.dart';

/// 플랫폼에 맞는 엔진 인스턴스를 안전하게 제공하는 클래스입니다.
class ShooterEngineProvider {
  static ShooterEngine provide() {
    // createEngine()은 조건부 임포트에 의해 플랫폼별 파일에서 로드됩니다.
    return createEngine();
  }
}
