import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// 앱의 프리미엄 게임 콘솔 디자인 시스템 색상 정의입니다.
class AppColors {
  // Deep Midnight & Cyber Theme
  static const Color background = Color(0xFF0D0D12);
  static const Color surface = Color(0xFF1C1C23);
  static const Color glassPrimary = Color(0x33FFFFFF);
  
  static const Color primary = Color(0xFF8B5CF6); // Electric Violet
  static const Color secondary = Color(0xFF06B6D4); // Cyber Cyan
  static const Color accent = Color(0xFFF43F5E); // Neon Rose
  
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color error = Color(0xFFEF4444);

  // Glow Effects
  static List<BoxShadow> neonGlow(Color color) => [
    BoxShadow(
      color: color.withValues(alpha: 0.5),
      blurRadius: 20,
      spreadRadius: 2,
    ),
    BoxShadow(
      color: color.withValues(alpha: 0.2),
      blurRadius: 40,
      spreadRadius: 5,
    ),
  ];

  static const BoxShadow glassShadow = BoxShadow(
    color: Colors.black26,
    blurRadius: 10,
    offset: Offset(0, 4),
  );
}

/// 앱의 통합 타이포그래피 정의입니다. (Google Fonts 사용)
class AppTypography {
  static TextStyle get headline1 => GoogleFonts.orbitron(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: 1.5,
  );

  static TextStyle get headline2 => GoogleFonts.orbitron(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get body1 => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static TextStyle get caption => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static TextStyle get numeric => GoogleFonts.shareTechMono(
    fontSize: 18,
    color: AppColors.secondary,
  );
}
