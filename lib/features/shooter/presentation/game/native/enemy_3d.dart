import 'package:flame/components.dart' show HasGameReference;
import 'package:flame_3d/components.dart';
import 'package:flame_3d/core.dart';
import 'package:flame_3d/resources.dart';

import '../../../../../core/design_system/styles.dart';
import '../../../../../core/engine/native_base_engine_3d.dart';
import 'player_3d.dart';

/// 플레이어를 위협하는 3D 적 컴포넌트입니다.
class Enemy3D extends MeshComponent with HasGameReference<BaseGameEngine3D> {
  Enemy3D({required super.position, this.speed = 3.0})
    : super(
        mesh: CuboidMesh(
          size: Vector3(1.5, 2.0, 1.5),
          material: SpatialMaterial(albedoColor: AppColors.error),
        ),
      );

  final double speed;
  bool isDead = false;
  static const double _attackRange = 2.0;
  static const double _damagePerSecond = 15.0;

  @override
  void update(double dt) {
    super.update(dt);
    if (isDead) return;

    // world에서 플레이어를 찾아 추적
    final player = world.children.whereType<Player3D>().firstOrNull;
    if (player != null) {
      final toPlayer = player.position - position;
      final dist = toPlayer.length;

      if (dist > _attackRange) {
        // 플레이어 방향으로 이동
        final direction = toPlayer..normalize();
        position.add(direction * speed * dt);
      } else {
        // 플레이어에 도달 — 데미지 부여
        game.updateHealth(-_damagePerSecond * dt);
      }
    }
  }

  void die() {
    if (isDead) return;
    takeDamage();
  }

  void takeDamage() {
    isDead = true;
    // 피격 연출 (색상 변경)
    mesh.surfaces.first.material = SpatialMaterial(
      albedoColor: AppColors.textSecondary,
    );

    // 잠시 후 소멸
    Future.delayed(const Duration(milliseconds: 200), () {
      removeFromParent();
    });
  }
}
