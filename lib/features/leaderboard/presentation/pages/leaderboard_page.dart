import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/design_system/styles.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/layouts/responsive_layout.dart';
import '../../../auth/presentation/viewmodels/login_view_model.dart';
import '../../domain/entities/score_entity.dart';
import '../viewmodels/leaderboard_view_model.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  late final LeaderboardViewModel _vm = getIt<LeaderboardViewModel>();
  late final LoginViewModel _authVm = getIt<LoginViewModel>();

  @override
  void initState() {
    super.initState();
    _vm.loadLeaderboard();
    final uid = _authVm.currentUser?.id;
    if (uid != null) _vm.loadMyScores(uid);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildLayout(context, padding: 24, maxWidth: 480),
      tablet: _buildLayout(context, padding: 48, maxWidth: 700),
      desktop: _buildLayout(context, padding: 96, maxWidth: 900),
    );
  }

  Widget _buildLayout(BuildContext context,
      {required double padding, required double maxWidth}) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
              top: -80,
              right: -80,
              child: _glow(AppColors.primary.withValues(alpha: 0.08), 300)),
          Positioned(
              bottom: -80,
              left: -80,
              child: _glow(AppColors.accent.withValues(alpha: 0.05), 240)),
          SafeArea(
            child: Column(
              children: [
                _buildAppBar(context),
                _buildGameTabs(),
                Expanded(
                  child: Watch((ctx) => _buildScoreList(ctx, padding, maxWidth)),
                ),
                Watch((ctx) => _buildMyRankBar(ctx)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new,
                color: Colors.white70, size: 20),
            onPressed: () => context.pop(),
          ),
          const SizedBox(width: 8),
          Text('리더보드',
              style: AppTypography.headline2
                  .copyWith(color: AppColors.primary, fontSize: 20)),
          const Spacer(),
          const Icon(Icons.emoji_events, color: AppColors.primary, size: 24),
        ],
      ),
    );
  }

  Widget _buildGameTabs() {
    return Watch((ctx) {
      final selected = _vm.selectedGame.value;
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          children: LeaderboardViewModel.games.map((game) {
            final isSelected = selected == game;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () => _vm.selectGame(game),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: isSelected
                        ? LinearGradient(colors: [
                            AppColors.primary,
                            AppColors.primaryLight
                          ])
                        : null,
                    border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : Colors.white.withValues(alpha: 0.1)),
                    color: isSelected
                        ? null
                        : Colors.white.withValues(alpha: 0.03),
                  ),
                  child: Text(
                    LeaderboardViewModel.gameLabels[game] ?? game,
                    style: AppTypography.body2.copyWith(
                      color: isSelected ? AppColors.background : AppColors.textDim,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    });
  }

  Widget _buildScoreList(BuildContext context, double padding, double maxWidth) {
    if (_vm.isLoading.value) {
      return const Center(
          child: CircularProgressIndicator(color: AppColors.primary));
    }
    final list = _vm.scores.value;
    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.sports_esports, color: AppColors.textDim, size: 48),
            const SizedBox(height: 16),
            Text('아직 점수가 없습니다',
                style: AppTypography.body1.copyWith(color: AppColors.textDim)),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 8),
      itemCount: list.length,
      itemBuilder: (ctx, i) => Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: _buildScoreRow(list[i], i + 1),
        ),
      ),
    );
  }

  Widget _buildScoreRow(ScoreEntity score, int rank) {
    final isMe = score.userId == _authVm.currentUser?.id;
    Color rankColor;
    IconData? rankIcon;
    if (rank == 1) {
      rankColor = const Color(0xFFFFD700);
      rankIcon = Icons.emoji_events;
    } else if (rank == 2) {
      rankColor = const Color(0xFFC0C0C0);
      rankIcon = Icons.emoji_events;
    } else if (rank == 3) {
      rankColor = const Color(0xFFCD7F32);
      rankIcon = Icons.emoji_events;
    } else {
      rankColor = AppColors.textDim;
      rankIcon = null;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isMe
            ? AppColors.primary.withValues(alpha: 0.08)
            : Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: isMe
                ? AppColors.primary.withValues(alpha: 0.3)
                : Colors.white.withValues(alpha: 0.06)),
        boxShadow: rank <= 3
            ? [BoxShadow(color: rankColor.withValues(alpha: 0.15), blurRadius: 8)]
            : null,
      ),
      child: Row(
        children: [
          // 순위
          SizedBox(
            width: 36,
            child: rankIcon != null
                ? Icon(rankIcon, color: rankColor, size: 22)
                : Text('$rank',
                    style: AppTypography.body1.copyWith(color: rankColor)),
          ),
          // 아바타
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surface,
              border: Border.all(
                  color: rankColor.withValues(alpha: 0.3), width: 1.5),
            ),
            child: Center(
              child: Text(
                (score.username.isNotEmpty ? score.username[0] : '?')
                    .toUpperCase(),
                style: TextStyle(
                    color: rankColor, fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // 이름 + 게임
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(score.username,
                    style: AppTypography.body1.copyWith(
                        color: isMe ? AppColors.primary : Colors.white,
                        fontWeight: isMe ? FontWeight.bold : FontWeight.normal)),
                Text(score.gameId,
                    style: AppTypography.caption
                        .copyWith(color: AppColors.textDim, fontSize: 10)),
              ],
            ),
          ),
          // 점수
          Text(
            score.score.toString(),
            style: AppTypography.headline2.copyWith(
              color: rank <= 3 ? rankColor : Colors.white,
              fontSize: 18,
              shadows: rank <= 3
                  ? [Shadow(color: rankColor.withValues(alpha: 0.5), blurRadius: 6)]
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyRankBar(BuildContext context) {
    final uid = _authVm.currentUser?.id;
    if (uid == null) return const SizedBox.shrink();
    final rank = _vm.getMyRank(uid);
    if (rank == -1) return const SizedBox.shrink();

    final myScore =
        _vm.scores.value.firstWhere((s) => s.userId == uid);

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            border: Border(
                top: BorderSide(
                    color: AppColors.primary.withValues(alpha: 0.2))),
          ),
          child: Row(
            children: [
              const Icon(Icons.person, color: AppColors.primary, size: 20),
              const SizedBox(width: 12),
              Text('내 순위', style: AppTypography.caption.copyWith(color: AppColors.textDim)),
              const SizedBox(width: 8),
              Text('#$rank',
                  style: AppTypography.headline2
                      .copyWith(color: AppColors.primary, fontSize: 16)),
              const Spacer(),
              Text('${myScore.score}점',
                  style: AppTypography.body1
                      .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _glow(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
        child: Container(color: Colors.transparent),
      ),
    );
  }
}
