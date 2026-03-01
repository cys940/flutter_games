import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame_3d/camera.dart';
import 'package:flame_3d/components.dart';
import 'package:flutter/services.dart';

import '../../../../../core/engine/native_base_engine_3d.dart';
import '../../../domain/engine/shooter_engine.dart';

/// 1인칭 시점을 제어하는 3D 플레이어 컴포넌트입니다.
class Player3D extends Component3D
    with KeyboardHandler, HasGameReference<BaseGameEngine3D> {
  Player3D() : super();

  final double moveSpeed = 8.0;
  final double rotateSpeed = 2.5;
  static const double _eyeHeight = 1.6;

  // 입력 상태
  final Vector3 _moveInput = Vector3.zero();
  double _yawInput = 0;
  double _pitchInput = 0;

  // 카메라 회전 상태 (라디안)
  double _yaw = 0;
  double _pitch = 0;

  CameraComponent3D get _camera => game.camera;

  /// 카메라가 바라보는 정면 방향 벡터
  Vector3 get forwardDirection {
    return Vector3(
      math.sin(_yaw) * math.cos(_pitch),
      math.sin(_pitch),
      -math.cos(_yaw) * math.cos(_pitch),
    )..normalize();
  }

  @override
  void update(double dt) {
    super.update(dt);

    // 1) 카메라 회전 적용
    _yaw += _yawInput * rotateSpeed * dt;
    _pitch = (_pitch + _pitchInput * rotateSpeed * dt).clamp(-1.2, 1.2);

    // 2) 카메라 방향 기준으로 이동 (Y축 무시하여 지면 이동)
    if (_moveInput.length2 > 0) {
      final flatForward = Vector3(math.sin(_yaw), 0, -math.cos(_yaw))
        ..normalize();
      final flatRight = Vector3(math.cos(_yaw), 0, math.sin(_yaw));

      final movement = flatForward * (-_moveInput.z) + flatRight * _moveInput.x;
      if (movement.length2 > 0) {
        movement.normalize();
        position.add(movement * moveSpeed * dt);
      }
    }

    // 3) 카메라를 플레이어 눈 높이에서 추적
    final eyePos = position + Vector3(0, _eyeHeight, 0);
    _camera.position.setFrom(eyePos);
    _camera.target.setFrom(eyePos + forwardDirection);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    _moveInput.setZero();
    _yawInput = 0;
    _pitchInput = 0;

    // WASD 이동
    if (keysPressed.contains(LogicalKeyboardKey.keyW)) _moveInput.z = -1;
    if (keysPressed.contains(LogicalKeyboardKey.keyS)) _moveInput.z = 1;
    if (keysPressed.contains(LogicalKeyboardKey.keyA)) _moveInput.x = -1;
    if (keysPressed.contains(LogicalKeyboardKey.keyD)) _moveInput.x = 1;
    if (_moveInput.length2 > 0) _moveInput.normalize();

    // 방향키 회전
    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) _yawInput = 1;
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) _yawInput = -1;
    if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) _pitchInput = 1;
    if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) _pitchInput = -1;

    // 스페이스바 사격 (KeyDown만, 리피트 제외)
    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.space) {
      if (game is ShooterEngine) {
        (game as ShooterEngine).fireBullet();
      }
    }

    return super.onKeyEvent(event, keysPressed);
  }
}
