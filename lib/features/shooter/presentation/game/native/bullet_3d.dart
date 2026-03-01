import 'package:flame/components.dart';
import 'package:flame_3d/components.dart';
import 'package:flame_3d/resources.dart';

import '../../../../../core/design_system/styles.dart';
import '../../../../../core/engine/native_base_engine_3d.dart';

/// 3D 공간에서 발사되는 총알 컴포넌트입니다.
class Bullet3D extends MeshComponent with HasGameReference<BaseGameEngine3D> {
  Bullet3D({required super.position, required this.direction})
    : super(
        mesh: SphereMesh(
          radius: 0.1,
          material: SpatialMaterial(albedoColor: AppColors.secondary),
        ),
      );

  final Vector3 direction;
  final double speed = 30.0;
  double lifeTime = 2.0;

  @override
  void update(double dt) {
    super.update(dt);
    position.add(direction * speed * dt);

    lifeTime -= dt;
    if (lifeTime <= 0) {
      removeFromParent();
    }
  }
}
