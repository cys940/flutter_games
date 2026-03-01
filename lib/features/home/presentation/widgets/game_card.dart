import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design_system/styles.dart';
import '../../../../core/presentation/widgets/glass_panel.dart';
import '../../domain/entities/game_entity.dart';

class GameCard extends StatefulWidget {
  const GameCard({
    super.key,
    required this.game,
  });
  final GameEntity game;

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    if (isHovered) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTap: () {
          context.push('/game/${widget.game.id}');
        },
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: GlassPanel(
                padding: const EdgeInsets.all(12),
                borderRadius: 12,
                borderColor: _isHovered ? AppColors.primary.withOpacity(0.4) : null,
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
                            color: Colors.white.withOpacity(0.05),
                          ),
                        ),
                        child: Image.network(
                          widget.game.thumbnailPath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.videogame_asset,
                            size: 32,
                            color: _isHovered ? AppColors.primary : AppColors.textDim,
                            shadows: _isHovered
                                ? [
                                    Shadow(
                                      color: AppColors.primary.withOpacity(0.8),
                                      blurRadius: 10,
                                    ),
                                  ]
                                : [],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.game.title,
                      style: AppTypography.headline2.copyWith(fontSize: 11),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${widget.game.gameType.name.toUpperCase()} • ${widget.game.playCount} PLAYS',
                      style: AppTypography.caption,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
