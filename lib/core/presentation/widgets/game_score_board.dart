import 'package:flutter/material.dart';
import '../../design_system/styles.dart';

/// 네온 글로우 스타일의 공통 점수판 위젯입니다.
class GameScoreBoard extends StatelessWidget {
  const GameScoreBoard({
    super.key,
    required this.score,
    this.label = 'SCORE',
    this.fontSize = 24,
    this.color = AppColors.secondary,
    this.padLeft = 6,
  });

  final int score;
  final String label;
  final double fontSize;
  final Color color;
  final int padLeft;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ${score.toString().padLeft(padLeft, '0')}',
          style: AppTypography.numeric.copyWith(
            fontSize: fontSize,
            color: color,
            shadows: [
              Shadow(color: color, blurRadius: 10),
            ],
          ),
        ),
      ],
    );
  }
}
