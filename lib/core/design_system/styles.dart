import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// 앱의 프리미엄 사이버펑크 게임 콘솔 디자인 시스템입니다.
class AppColors {
  // Deep Space & Ultra Dark Backgrounds
  static const Color background = Color(0xFF0B0E14);
  static const Color backgroundDark = Color(0xFF050508);
  static const Color surface = Color(0xFF131721);

  // Cyber Core Colors
  static const Color primary = Color(0xFF00F0FF); // Electric Blue
  static const Color primaryLight = Color(0xFF90F9FF); // Lighter Electric Blue
  static const Color secondary = Color(0xFFBC00FF); // Vivid Purple
  static const Color accent = Color(0xFFFF4444); // Neon Rose/Red

  // Status & Utility
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textDim = Color(0xFF64748B);
  static const Color error = Color(0xFFFF4444);

  // Glassmorphism & Overlays
  static Color glassBackground = const Color(0xFF131721).withValues(alpha: 0.6);
  static Color glassBorder = Colors.white.withValues(alpha: 0.08);

  // Glow & Shadow Effects
  static List<BoxShadow> neonGlow(Color color) => [
    BoxShadow(
      color: color.withValues(alpha: 0.4),
      blurRadius: 15,
      spreadRadius: 2,
    ),
    BoxShadow(
      color: color.withValues(alpha: 0.2),
      blurRadius: 30,
      spreadRadius: 5,
    ),
  ];

  static const BoxShadow glassShadow = BoxShadow(
    color: Colors.black45,
    blurRadius: 32,
    offset: Offset(0, 8),
  );
}

/// 앱의 통합 타이포그래피 정의입니다. (Orbitron & Exo 2 사용)
class AppTypography {
  // Display Font (Orbitron) - Titles, Headers, UI Accents
  static TextStyle get headline1 => GoogleFonts.orbitron(
    fontSize: 24,
    fontWeight: FontWeight.w900,
    color: AppColors.textPrimary,
    letterSpacing: 1.5,
  );

  static TextStyle get headline2 => GoogleFonts.orbitron(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: 1.0,
  );

  static TextStyle get caption => GoogleFonts.orbitron(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    color: AppColors.textSecondary,
    letterSpacing: 1.2,
  );

  // Body Font (Exo 2) - General Text, Descriptions
  static TextStyle get body1 => GoogleFonts.exo2(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );

  static TextStyle get body2 => GoogleFonts.exo2(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle get numeric => GoogleFonts.shareTechMono(
    fontSize: 18,
    color: AppColors.primary,
    letterSpacing: 1.5,
  );
}
