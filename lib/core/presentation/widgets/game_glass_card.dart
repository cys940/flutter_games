import 'dart:ui';
import 'package:flutter/material.dart';

/// 게임 테마에 어울리는 유리 질감의 투명 컨테이너 위젯입니다.
class GameGlassCard extends StatelessWidget {
  const GameGlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = 24,
    this.blur = 10,
    this.opacity = 0.05,
    this.borderColor,
    this.gradient,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double blur;
  final double opacity;
  final Color? borderColor;
  final Gradient? gradient;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cardContent = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: gradient == null ? Colors.white.withValues(alpha: opacity) : null,
            gradient: gradient,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: borderColor ?? Colors.white12),
          ),
          child: child,
        ),
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: margin,
          child: cardContent,
        ),
      );
    }

    return Container(
      margin: margin,
      child: cardContent,
    );
  }
}
