import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/design_system/styles.dart';
import '../../../../core/presentation/widgets/game_glass_card.dart';
import '../../../../core/presentation/widgets/game_gauge.dart';
import '../../../../core/presentation/widgets/game_score_board.dart';
import '../../../../core/presentation/widgets/game_status_tag.dart';
import '../game/shooter_game_widget.dart';
import '../viewmodels/shooter_view_model.dart';

/// 3D 슈팅 게임의 메인 페이지입니다. 고도화된 스포티한 HUD가 포함됩니다.
class ShooterPage extends StatelessWidget {
  const ShooterPage({super.key, required this.viewModel});
  final ShooterViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 플랫폼별 게임 월드 렌더링 (3D or 2D)
          ShooterGameWidget(engine: viewModel.gameEngine),

          // Vignette 이펙트 (몰입감 증대)
          IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.5),
                  ],
                  stops: const [0.6, 1.0],
                ),
              ),
            ),
          ),

          // 상단 HUD: 점수 및 상태
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left: Score & Health
                  Watch(
                    (context) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const GameStatusTag(label: 'MISSION STATUS: ACTIVE'),
                        const SizedBox(height: 10),
                        GameScoreBoard(score: viewModel.score.value),
                        const SizedBox(height: 15),
                        // Health Bar (Dynamic)
                        GameGauge(
                          value: viewModel.health.value,
                          label: 'HP ${viewModel.health.value.toInt()}%',
                          icon: Icons.favorite,
                        ),
                      ],
                    ),
                  ),

                  // Right: Controls / Back
                  Column(
                    children: [
                      GameGlassCard(
                        borderRadius: 12,
                        padding: EdgeInsets.zero,
                        onTap: () => context.pop(),
                        child: const SizedBox(
                          width: 44,
                          height: 44,
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 중앙 크로스헤어 (정교화)
          Center(child: _buildCrosshair()),

          // 하단 안내 메시지
          Positioned(
            bottom: 30,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Text(
                      'W,A,S,D MOVE | ARROWS LOOK | SPACE FIRE',
                      style: AppTypography.caption.copyWith(
                        color: Colors.white70,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCrosshair() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer Circle
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white24, width: 1),
          ),
        ),
        // Inner Points
        ...List.generate(4, (index) {
          return Transform.translate(
            offset: Offset(
              15 * (index % 2 == 0 ? 0 : (index == 1 ? 1 : -1)),
              15 * (index % 2 != 0 ? 0 : (index == 0 ? -1 : 1)),
            ),
            child: Container(
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
              ),
            ),
          );
        }),
        const Icon(Icons.add, color: AppColors.secondary, size: 20),
      ],
    );
  }
}
