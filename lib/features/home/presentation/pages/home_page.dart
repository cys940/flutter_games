import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/design_system/styles.dart';
import '../../../../core/layouts/responsive_layout.dart';
import '../../../../core/presentation/widgets/game_glass_card.dart';
import '../../../../core/presentation/widgets/game_score_board.dart';
import '../../../../core/presentation/widgets/game_status_tag.dart';
import '../../domain/entities/game_entity.dart';
import '../viewmodels/home_view_model.dart';

/// 앱의 메인 홈 페이지입니다. 프리미엄 게임 콘솔 감성을 제공합니다.
class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.viewModel});
  final HomeViewModel viewModel;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    
    // 초기 데이터 로딩
    widget.viewModel.fetchGames();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AppBar(
              title: Text('GAME PACK', style: AppTypography.headline1),
              centerTitle: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                Watch((context) => GameScoreBoard(
                  score: widget.viewModel.totalScore.value,
                  fontSize: 14,
                  label: 'TOTAL SCORE',
                )),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background Gradient Deco
          Positioned(
            top: -100,
            right: -100,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) => Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.2 + (0.1 * _controller.value)),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          ResponsiveLayout(
            mobile: _buildContent(context, isMobile: true),
            tablet: _buildContent(context, isMobile: false),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, {required bool isMobile}) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          // 상단: 프리미엄 게임 엔진 프리뷰 영역
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: AppColors.neonGlow(AppColors.secondary),
                  ),
                ),
                const SizedBox(width: 10),
                Text('ENGINE PREVIEW', style: AppTypography.headline2),
              ],
            ),
          ),
          GameGlassCard(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.zero,
            child: SizedBox(
              height: 220,
              child: Stack(
                children: [
                  GameWidget(game: widget.viewModel.gameEngine),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black87],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'FLAME REALTIME ENGINE',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        Text(
                          'High-Performance 3D Rendering',
                          style: AppTypography.body1.copyWith(fontSize: 12, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  const Positioned(
                    top: 15,
                    right: 20,
                    child: GameStatusTag(
                      label: 'LIVE',
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 30),
          
          // 중앙: 게임 팩 (그리드 레이아웃)
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 20),
            child: Text('AVAILABLE GAMES', style: AppTypography.headline2),
          ),
          Expanded(
            child: Watch((context) {
              if (widget.viewModel.isLoading.value) {
                return const Center(child: CircularProgressIndicator(color: AppColors.primary));
              }

              final gameList = widget.viewModel.games.value;
              return GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 2 : 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.8,
                ),
                itemCount: gameList.length,
                itemBuilder: (context, index) {
                  return _GameCard(game: gameList[index]);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _GameCard extends StatefulWidget {
  const _GameCard({required this.game});
  final GameEntity game;

  @override
  State<_GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<_GameCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isShooter = widget.game.id == 'shooter';
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: GestureDetector(
          onTap: () {
            if (isShooter) {
              context.push('/shooter');
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.surface,
                  content: Text(
                    '${widget.game.title} is coming soon!',
                    style: AppTypography.body1,
                  ),
                ),
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: _isHovered ? AppColors.primary.withValues(alpha: 0.5) : Colors.white12,
              ),
              boxShadow: _isHovered ? AppColors.neonGlow(AppColors.primary) : [AppColors.glassShadow],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isShooter 
                        ? [AppColors.primary.withValues(alpha: 0.4), AppColors.secondary.withValues(alpha: 0.2)]
                        : [Colors.white.withValues(alpha: 0.05), Colors.white.withValues(alpha: 0.02)],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: isShooter ? [Colors.white, AppColors.secondary] : [Colors.white54, Colors.white12],
                        ).createShader(bounds),
                        child: Icon(
                          isShooter ? Icons.view_in_ar : Icons.videogame_asset,
                          size: 56,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.game.title,
                        style: AppTypography.headline2.copyWith(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          widget.game.description,
                          style: AppTypography.caption,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
