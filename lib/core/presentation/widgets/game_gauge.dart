import 'package:flutter/material.dart';
import '../../design_system/styles.dart';

/// 애니메이션이 적용된 공통 게임 게이지(HP 등) 위젯입니다.
class GameGauge extends StatelessWidget {
  const GameGauge({
    super.key,
    required this.value,
    this.maxValue = 100,
    this.width = 180,
    this.height = 6,
    this.label,
    this.icon,
    this.activeColor,
    this.backgroundColor = Colors.white12,
  });

  final double value;
  final double maxValue;
  final double width;
  final double height;
  final String? label;
  final IconData? icon;
  final Color? activeColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final normalizedValue = (value / maxValue).clamp(0.0, 1.0);
    final color =
        activeColor ??
        (normalizedValue > 0.3 ? AppColors.secondary : AppColors.accent);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null || icon != null) ...[
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: color, size: 14),
                const SizedBox(width: 5),
              ],
              if (label != null)
                Text(
                  label!,
                  style: AppTypography.caption.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
        ],
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(height / 2),
          ),
          child: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: width * normalizedValue,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withValues(alpha: 0.5)],
                  ),
                  borderRadius: BorderRadius.circular(height / 2),
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.5),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
