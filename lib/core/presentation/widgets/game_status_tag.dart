import 'package:flutter/material.dart';
import '../../design_system/styles.dart';

/// 게임 내 상태(LIVE, ACTIVE 등)를 표시하는 공통 태그 위젯입니다.
class GameStatusTag extends StatelessWidget {
  const GameStatusTag({
    super.key,
    required this.label,
    this.color,
    this.fontSize = 10,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
  });

  final String label;
  final Color? color;
  final double fontSize;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: (color ?? AppColors.primary).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}
