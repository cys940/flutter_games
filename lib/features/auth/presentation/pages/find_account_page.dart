import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/design_system/styles.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/layouts/responsive_layout.dart';
import '../viewmodels/login_view_model.dart';

class FindAccountPage extends StatefulWidget {
  const FindAccountPage({super.key});

  @override
  State<FindAccountPage> createState() => _FindAccountPageState();
}

class _FindAccountPageState extends State<FindAccountPage> {
  final _viewModel = getIt<LoginViewModel>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobileLayout(context),
      tablet: _buildTabletLayout(context),
      desktop: _buildDesktopLayout(context),
    );
  }

  Widget _buildBaseLayout({
    required BuildContext context,
    required double horizontalPadding,
    required double maxWidth,
    required double glowSize1,
    required double glowTop1,
    required double glowRight1,
    required double glowSize2,
    required double glowBottom2,
    required double glowLeft2,
  }) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Ambient Glow Effects
          Positioned(
            top: glowTop1,
            right: glowRight1,
            child: _buildAmbientGlow(AppColors.accent.withValues(alpha: 0.1), glowSize1),
          ),
          Positioned(
            bottom: glowBottom2,
            left: glowLeft2,
            child: _buildAmbientGlow(AppColors.primary.withValues(alpha: 0.05), glowSize2),
          ),

          // Main Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 40),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 48),
                      _buildInputSection(),
                      const SizedBox(height: 32),
                      _buildRecoverButton(),
                      const SizedBox(height: 24),
                      _buildFooterNav(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Back Button
          Positioned(
            top: 20,
            left: 20,
            child: SafeArea(
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white70),
                onPressed: () => context.pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return _buildBaseLayout(
      context: context,
      horizontalPadding: 24,
      maxWidth: 400,
      glowSize1: 200,
      glowTop1: -50,
      glowRight1: -50,
      glowSize2: 150,
      glowBottom2: -40,
      glowLeft2: -40,
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return _buildBaseLayout(
      context: context,
      horizontalPadding: 48,
      maxWidth: 600,
      glowSize1: 250,
      glowTop1: -75,
      glowRight1: -75,
      glowSize2: 200,
      glowBottom2: -60,
      glowLeft2: -60,
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return _buildBaseLayout(
      context: context,
      horizontalPadding: 96,
      maxWidth: 800,
      glowSize1: 300,
      glowTop1: -100,
      glowRight1: -100,
      glowSize2: 250,
      glowBottom2: -80,
      glowLeft2: -80,
    );
  }

  Widget _buildAmbientGlow(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
        child: Container(color: Colors.transparent),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: 0.1),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.accent.withValues(alpha: 0.2)),
          ),
          child: const Icon(Icons.security, color: AppColors.accent, size: 32),
        ),
        const SizedBox(height: 24),
        Text(
          '계정 찾기',
          style: AppTypography.headline1.copyWith(
            fontSize: 28,
            color: AppColors.accent,
            shadows: [
              Shadow(
                color: AppColors.accent.withValues(alpha: 0.5),
                blurRadius: 8,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '보안 링크 생성',
          style: AppTypography.caption.copyWith(
            color: AppColors.textDim,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }

  Widget _buildInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            '등록된 이메일',
            style: AppTypography.caption.copyWith(
              color: AppColors.accent.withValues(alpha: 0.8),
              fontSize: 10,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Icon(Icons.email_outlined, color: AppColors.textDim, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _emailController,
                  style: AppTypography.body1,
                  decoration: InputDecoration(
                    hintText: '이메일 주소를 입력하세요',
                    hintStyle: AppTypography.body2.copyWith(color: AppColors.textDim),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecoverButton() {
    return Watch((context) {
      final isLoading = _viewModel.isLoading.value;
      return GestureDetector(
        onTap: isLoading ? null : _handleRecovery,
        child: MouseRegion(
          cursor: isLoading ? SystemMouseCursors.basic : SystemMouseCursors.click,
          child: Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              boxShadow: AppColors.neonGlow(AppColors.accent),
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: isLoading
                    ? [
                        AppColors.accent.withValues(alpha: 0.5),
                        AppColors.accent.withValues(alpha: 0.5)
                      ]
                    : [AppColors.accent, const Color(0xFFFF6B6B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(AppColors.background),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '비밀번호 재설정 링크 전송',
                          style: AppTypography.headline2.copyWith(
                            color: AppColors.background,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.send_rounded,
                            color: AppColors.background, size: 20),
                      ],
                    ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildFooterNav() {
    return TextButton(
      onPressed: () => context.pop(),
      child: Text(
        '로그인 화면으로 돌아가기',
        style: AppTypography.body2.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Future<void> _handleRecovery() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      _showError('이메일 주소를 입력해 주세요.');
      return;
    }

    await _viewModel.resetPassword(email);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('재설정 링크가 전송되었습니다. 이메일을 확인해 주세요.'),
          backgroundColor: Colors.green,
        ),
      );
      context.pop();
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
