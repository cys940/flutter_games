import 'dart:math' as math;
import 'package:flame_3d/components.dart';
import 'package:flame_3d/game.dart';
import 'package:vector_math/vector_math.dart' as v_math;

import '../../../../../core/engine/native_base_engine_3d.dart';
import '../../../domain/engine/shooter_engine.dart';
import '../native/bullet_3d.dart';
import '../native/enemy_3d.dart';
import '../native/player_3d.dart';

class ShooterEngineNative extends BaseGameEngine3D implements ShooterEngine {
  late final Player3D player;

  // 웨이브 시스템 관련 변수
  int _currentWave = 0;
  int _enemiesRemainingInWave = 0;
  int _totalEnemiesInWave = 0;
  double _waveTimer = 0;
  bool _isWaveActive = false;

  double _spawnTimer = 0;
  double _spawnInterval = 2.0;

  @override
  Future<void> onLoad() async {
    player = Player3D();
    world.add(player);

    // 조명 추가 (World3D에 추가해야 함)
    world.add(LightComponent.ambient(intensity: 0.3));
    world.add(
      LightComponent.point(intensity: 1.0, position: v_math.Vector3(5, 10, 5)),
    );

    // 초기 웨이브 시작
    _startNextWave();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!_isWaveActive) {
      _waveTimer += dt;
      if (_waveTimer >= 3.0) {
        _startNextWave();
      }
      return;
    }

    // 적 스폰 로직
    if (_enemiesRemainingInWave > 0) {
      _spawnTimer += dt;
      if (_spawnTimer >= _spawnInterval) {
        _spawnTimer = 0;
        _spawnEnemy();
        _enemiesRemainingInWave--;
      }
    } else {
      // 모든 적이 생성되었고, 필드에 적이 없으면 웨이브 종료
      final activeEnemies = world.children.whereType<Enemy3D>().where(
        (e) => !e.isDead,
      );
      if (activeEnemies.isEmpty) {
        _endWave();
      }
    }

    // 충돌 감지 로직 (Bullet vs Enemy)
    _checkCollisions();
  }

  void _startNextWave() {
    _currentWave++;
    _totalEnemiesInWave = 3 + (_currentWave * 2);
    _enemiesRemainingInWave = _totalEnemiesInWave;
    _spawnInterval = (2.0 - (_currentWave * 0.1)).clamp(0.5, 2.0);
    _isWaveActive = true;
    _waveTimer = 0;
  }

  void _endWave() {
    _isWaveActive = false;
    _waveTimer = 0;
    addScore(500);
  }

  void _spawnEnemy() {
    final random = math.Random();
    final angle = random.nextDouble() * math.pi * 2;
    const radius = 25.0;
    final x = math.cos(angle) * radius;
    final z = math.sin(angle) * radius;

    final enemy = Enemy3D(
      position: Vector3(x, 0, z),
      speed: 3.0 + (_currentWave * 0.3),
    );
    world.add(enemy);
  }

  void _checkCollisions() {
    final activeBullets = world.children.whereType<Bullet3D>().toList();
    final activeEnemies = world.children.whereType<Enemy3D>().toList();

    for (final bullet in activeBullets) {
      for (final enemy in activeEnemies) {
        if (enemy.isDead) continue;

        if (bullet.position.distanceTo(enemy.position) < 2.0) {
          enemy.die();
          bullet.removeFromParent();
          addScore(100);
          break;
        }
      }
    }
  }

  @override
  void fireBullet() {
    // 플레이어의 카메라 방향으로 발사
    final bulletDirection = player.forwardDirection;

    final bullet = Bullet3D(
      position: player.position.clone()..add(v_math.Vector3(0, 1.5, 0)),
      direction: bulletDirection,
    );
    world.add(bullet);
  }

  @override
  void reset() {
    healthSignal.value = 100.0;
    scoreSignal.value = 0;
    _currentWave = 0;

    for (final enemy in world.children.whereType<Enemy3D>().toList()) {
      enemy.removeFromParent();
    }
    for (final bullet in world.children.whereType<Bullet3D>().toList()) {
      bullet.removeFromParent();
    }
    _startNextWave();
  }
}
