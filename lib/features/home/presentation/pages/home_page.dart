import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/design_system/styles.dart';
import '../../../../core/layouts/responsive_layout.dart';
import '../../../../core/presentation/widgets/glass_panel.dart';
import '../../../../core/presentation/widgets/neon_button.dart';
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
                padding: const EdgeInsets.symmetric(horizontal: 0),
                sliver: SliverToBoxAdapter(
                  child: ResponsiveLayout(
                    mobile: _buildMainContent(isMobile: true),
                    tablet: _buildMainContent(isMobile: false),
                  ),
                ),
              ),

              // Bottom spacing for navigation
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),

          // Custom Bottom Navigation
          Positioned(left: 0, right: 0, bottom: 0, child: _buildBottomNav()),
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

  Widget _buildMainContent({required bool isMobile}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Featured Section
        _buildSectionHeader('Featured', AppColors.primary),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _buildFeaturedCard(isMobile),
        ),

        const SizedBox(height: 32),

        // Engine Core Section
        _buildSectionHeader('Engine Core', AppColors.secondary, showLive: true),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _buildEngineCard(),
        ),

        const SizedBox(height: 32),

        // Recent Ops
        _buildSectionHeader(
          'Recent Ops',
          AppColors.primary,
          actionLabel: 'View All',
        ),
        const SizedBox(height: 12),
        _buildRecentOpsList(),

        const SizedBox(height: 32),

        // Trending
        _buildSectionHeader('Trending', AppColors.secondary),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _buildTrendingGrid(isMobile),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(
    String title,
    Color color, {
    bool showLive = false,
    String? actionLabel,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: AppColors.neonGlow(color),
                ),
              ),
              const SizedBox(width: 12),
              Text(title.toUpperCase(), style: AppTypography.headline2),
              if (showLive) ...[
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.2),
                    border: Border.all(color: AppColors.accent),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'LIVE',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.accent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          if (actionLabel != null)
            TextButton(
              onPressed: () {},
              child: Text(
                actionLabel.toUpperCase(),
                style: AppTypography.caption.copyWith(
                  color: AppColors.primary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFeaturedCard(bool isMobile) {
    return Container(
      height: 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withValues(alpha: 0.2),
            blurRadius: 40,
            spreadRadius: -10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Dark Gradient Background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF1A0B2E),
                    Color(0xFF0B0E14),
                    Color(0xFF051820),
                  ],
                ),
              ),
            ),
            // Center Hexagon Icon Placeholder/Representation
            Center(
              child: Opacity(
                opacity: 0.1,
                child: const Icon(Icons.hexagon_outlined, size: 200, color: AppColors.primary),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.view_in_ar,
                    size: 80,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '3D SHOOTER',
                    style: AppTypography.headline1.copyWith(fontSize: 32),
                  ),
                  Text(
                    'Immersive tactical combat simulation',
                    style: AppTypography.body2.copyWith(
                      color: AppColors.textDim,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 30),
                  NeonButton(
                    label: 'Initialize',
                    icon: Icons.play_arrow,
                    onPressed: () => context.push('/shooter'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEngineCard() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // Background Image representation
            Positioned.fill(
              child: Image.network(
                'https://images.unsplash.com/photo-1550751827-4bd374c3f58b?auto=format&fit=crop&w=800&q=80',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(color: Colors.black54),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.black,
                    Colors.black.withValues(alpha: 0.8),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.bolt,
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'FLAME ENGINE 4.0',
                    style: AppTypography.headline2.copyWith(
                      fontSize: 14,
                      color: AppColors.primary,
                      shadows: [
                        Shadow(
                          color: AppColors.primary.withValues(alpha: 0.5),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ),
                  Text('REALTIME RAYTRACING', style: AppTypography.caption),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentOpsList() {
    final gameList = widget.viewModel.games.value;
    return SizedBox(
      height: 120,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: gameList.length,
        itemBuilder: (context, index) {
          final game = gameList[index];
          final color = index % 2 == 0
              ? AppColors.primary
              : AppColors.secondary;
          return Container(
            width: 260,
            margin: const EdgeInsets.only(right: 16),
            child: GlassPanel(
              borderRadius: 12,
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.videogame_asset,
                      color: color.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          game.title,
                          style: AppTypography.headline2.copyWith(fontSize: 14),
                        ),
                        Text('${game.score} LVL', style: AppTypography.caption),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: 0.75, // Sample value
                          backgroundColor: Colors.white.withValues(alpha: 0.1),
                          color: color,
                          minHeight: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTrendingGrid(bool isMobile) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 2 : 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        const items = [
          {
            'icon': Icons.rocket_launch,
            'title': 'Space Odyssey',
            'color': AppColors.primary,
          },
          {
            'icon': Icons.bolt,
            'title': 'Neon Racer',
            'color': AppColors.secondary,
          },
          {
            'icon': Icons.sports_esports,
            'title': 'Cyber Fight',
            'color': AppColors.accent,
          },
          {
            'icon': Icons.extension,
            'title': 'Puzzle Matrix',
            'color': Colors.greenAccent,
          },
        ];
        final item = items[index];
        return _TrendingCard(
          icon: item['icon'] as IconData,
          title: item['title'] as String,
          color: item['color'] as Color,
        );
      },
    );
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

class _TrendingCard extends StatefulWidget {
  const _TrendingCard({
    required this.icon,
    required this.title,
    required this.color,
  });
  final IconData icon;
  final String title;
  final Color color;

  @override
  State<_TrendingCard> createState() => _TrendingCardState();
}

class _TrendingCardState extends State<_TrendingCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        child: GlassPanel(
          padding: const EdgeInsets.all(12),
          borderRadius: 12,
          borderColor: _isHovered ? widget.color.withValues(alpha: 0.4) : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundDark,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.05),
                    ),
                  ),
                  child: Icon(
                    widget.icon,
                    size: 32,
                    color: _isHovered ? widget.color : AppColors.textDim,
                    shadows: _isHovered
                        ? [
                            Shadow(
                              color: widget.color.withValues(alpha: 0.8),
                              blurRadius: 10,
                            ),
                          ]
                        : [],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.title,
                style: AppTypography.headline2.copyWith(fontSize: 11),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'ACTION • PVP',
                style: AppTypography.caption,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
