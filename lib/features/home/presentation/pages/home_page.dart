import '../../../../core/presentation/widgets/glass_panel.dart';
import '../../domain/entities/game_entity.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/design_system/styles.dart';
import '../../../../core/layouts/responsive_layout.dart';
import '../widgets/game_card.dart';

import '../viewmodels/home_view_model.dart';

/// 앱의 메인 홈 페이지입니다. 프리미엄 사이버펑크 디자인과 반응형 레이아웃을 제공합니다.
class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.viewModel});
  final HomeViewModel viewModel;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    widget.viewModel.fetchGames();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Glow Decoration
          _buildBackgroundDeco(),

          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Sticky Glass Header
              _buildSliverHeader(),

              // Search Bar
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: _buildSearchBar(),
                ),
              ),

              // Responsive Content
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: Watch((context) => _buildMainContent()),
              ),

              // Bottom spacing for navigation
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),

          // Custom Bottom Navigation
          Watch(
            (context) => ResponsiveLayout.isMobile(context)
                ? Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: _buildBottomNav(),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundDeco() {
    return Positioned(
      top: -150,
      right: -100,
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) => Container(
          width: 400,
          height: 400,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppColors.secondary.withValues(
                  alpha: 0.15 + (0.05 * _pulseController.value),
                ),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSliverHeader() {
    return SliverAppBar(
      pinned: true,
      floating: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 80,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            color: AppColors.background.withValues(alpha: 0.8),
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.white, Color(0xFFAAAAAA)],
                  ).createShader(bounds),
                  child: Text(
                    'GAME PACK',
                    style: AppTypography.headline1.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Watch(
                  (context) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'SCORE ',
                          style: AppTypography.caption.copyWith(
                            fontSize: 10,
                            color: AppColors.textDim,
                          ),
                        ),
                        Text(
                          widget.viewModel.totalScore.value.toString(),
                          style: AppTypography.numeric.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: AppColors.primary.withValues(alpha: 0.5),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return GlassPanel(
      padding: EdgeInsets.zero,
      borderRadius: 12,
      child: TextField(
        style: AppTypography.body1,
        decoration: InputDecoration(
          hintText: 'Search library...',
          hintStyle: AppTypography.body2.copyWith(color: AppColors.textDim),
          prefixIcon: const Icon(Icons.search, color: AppColors.textDim),
          suffixIcon: IconButton(
            icon: const Icon(Icons.tune, color: AppColors.textDim),
            onPressed: () {},
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Watch((context) {
      final gameList = widget.viewModel.games.value;
      if (gameList.isEmpty) {
        return SliverToBoxAdapter(
          child: SizedBox(
            height: 200,
            child: Center(
              child: Text(
                'No games available.',
                style: AppTypography.body1.copyWith(color: AppColors.textDim),
              ),
            ),
          ),
        );
      }
      return SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: ResponsiveLayout.isDesktop(context)
              ? 4
              : ResponsiveLayout.isTablet(context)
                  ? 3
                  : 2, // 2 columns for mobile, 3 for tablet, 4 for desktop
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemCount: gameList.length,
        itemBuilder: (context, index) {
          final game = gameList[index];
          return GameCard(game: game);
        },
      );
    });
  }











  Widget _buildBottomNav() {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: 100,
          color: AppColors.background.withValues(alpha: 0.8),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(Icons.home, 'Home', isActive: true),
              _buildNavItem(Icons.explore, 'Find'),
              _buildCenterPlayItem(),
              _buildNavItem(Icons.emoji_events, 'Rank'),
              _buildNavItem(Icons.person, 'User'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, {bool isActive = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isActive ? AppColors.primary : AppColors.textDim,
          size: 28,
          shadows: isActive
              ? [Shadow(color: AppColors.primary, blurRadius: 10)]
              : [],
        ),
        const SizedBox(height: 4),
        Text(
          label.toUpperCase(),
          style: AppTypography.caption.copyWith(
            color: isActive ? AppColors.primary : AppColors.textDim,
            fontSize: 9,
          ),
        ),
      ],
    );
  }

  Widget _buildCenterPlayItem() {
    return Transform.translate(
      offset: const Offset(0, -30),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF1A1A2E), Color(0xFF0B0E14)],
              ),
              border: Border.all(color: AppColors.primary, width: 2),
            ),
            child: const Icon(
              Icons.play_arrow,
              color: AppColors.primary,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}


