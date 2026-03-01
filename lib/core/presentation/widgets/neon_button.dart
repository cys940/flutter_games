import 'package:flutter/material.dart';
import '../../design_system/styles.dart';

/// 사이버펑크 감성의 스큐(Skew) 효과와 글로우가 적용된 버튼입니다.
class NeonButton extends StatefulWidget {
  const NeonButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.color = AppColors.primary,
    this.isFullWidth = false,
    this.skew = -0.15,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color color;
  final bool isFullWidth;
  final double skew;

  @override
  State<NeonButton> createState() => _NeonButtonState();
}

class _NeonButtonState extends State<NeonButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.isFullWidth ? double.infinity : null,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: _isHovered
                ? widget.color
                : widget.color.withValues(alpha: 0.1),
            border: Border.all(color: widget.color, width: 1.5),
            boxShadow: _isHovered ? AppColors.neonGlow(widget.color) : [],
          ),
          transform: Matrix4.skewX(widget.skew),
          child: Transform(
            // 텍스트는 반대로 기울여서 똑바로 보이게 함
            transform: Matrix4.skewX(-widget.skew),
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null) ...[
                  Icon(
                    widget.icon,
                    color: _isHovered ? Colors.black : widget.color,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                ],
                Text(
                  widget.label.toUpperCase(),
                  style: AppTypography.headline2.copyWith(
                    fontSize: 14,
                    color: _isHovered ? Colors.black : widget.color,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
