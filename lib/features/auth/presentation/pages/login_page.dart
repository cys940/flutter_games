import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/design_system/styles.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/layouts/responsive_layout.dart';
import '../viewmodels/login_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _viewModel = getIt<LoginViewModel>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
            child: _buildAmbientGlow(
              AppColors.primary.withValues(alpha: 0.1),
              glowSize1,
            ),
          ),
          Positioned(
            bottom: glowBottom2,
            left: glowLeft2,
            child: _buildAmbientGlow(
              AppColors.primary.withValues(alpha: 0.05),
              glowSize2,
            ),
          ),

          // Main Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      _buildHeader(),
                      const SizedBox(height: 40),
                      _buildInputSection(),
                      const SizedBox(height: 8),
                      // 에러 메시지 표시
                      Watch((context) {
                        final error = _viewModel.errorMessage.value;
                        if (error == null) return const SizedBox.shrink();
                        return Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.red.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            error,
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontSize: 12,
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 16),
                      _buildLoginButton(),
                      const SizedBox(height: 16),
                      _buildHelperLinks(),
                      const SizedBox(height: 40),
                      _buildSocialLoginSection(),
                      const SizedBox(height: 20),
                      _buildFooter(),
                    ],
                  ),
                ),
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
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
        child: Container(color: Colors.transparent),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(color: Colors.transparent),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: const Icon(
                Icons.sports_esports,
                color: AppColors.primary,
                size: 36,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'GAME PACK',
          style: AppTypography.headline1.copyWith(
            fontSize: 32,
            shadows: [
              Shadow(
                color: AppColors.primary.withValues(alpha: 0.5),
                blurRadius: 8,
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '로그인',
          style: AppTypography.headline1.copyWith(
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
        _buildLabel('아이디 / 이메일'),
        const SizedBox(height: 8),
        _buildTextField(
          controller: _emailController,
          hintText: '아이디를 입력하세요',
          icon: Icons.person_outline,
          onChanged: (value) => _viewModel.email.value = value,
        ),
        const SizedBox(height: 20),
        _buildLabel('비밀번호'),
        const SizedBox(height: 8),
        Watch(
          (context) => _buildTextField(
            controller: _passwordController,
            hintText: '비밀번호를 입력하세요',
            icon: Icons.lock_outline,
            obscureText: !_viewModel.isPasswordVisible.value,
            suffixIcon: IconButton(
              icon: Icon(
                _viewModel.isPasswordVisible.value
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: AppColors.textDim,
                size: 20,
              ),
              onPressed: _viewModel.togglePasswordVisibility,
            ),
            onChanged: (value) => _viewModel.password.value = value,
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text,
        style: AppTypography.caption.copyWith(
          color: AppColors.primary.withValues(alpha: 0.8),
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    Function(String)? onChanged,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textDim, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              onChanged: onChanged,
              style: AppTypography.body1,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTypography.body2.copyWith(
                  color: AppColors.textDim,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          suffixIcon ?? const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return Watch((context) {
      final isLoading = _viewModel.isLoading.value;
      return GestureDetector(
        onTap: isLoading ? null : _viewModel.login,
        child: MouseRegion(
          cursor: isLoading
              ? SystemMouseCursors.basic
              : SystemMouseCursors.click,
          onEnter: (_) => _viewModel.isHoveringLogin.value = true,
          onExit: (_) => _viewModel.isHoveringLogin.value = false,
          child: AnimatedScale(
            scale: isLoading
                ? 1.0
                : (_viewModel.isHoveringLogin.value ? 1.03 : 1.0),
            duration: const Duration(milliseconds: 150),
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                boxShadow: AppColors.neonGlow(AppColors.primary),
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: isLoading
                      ? [
                          AppColors.primary.withValues(alpha: 0.5),
                          AppColors.primary.withValues(alpha: 0.5),
                        ]
                      : [AppColors.primary, AppColors.primaryLight],
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
                          valueColor: AlwaysStoppedAnimation(
                            AppColors.background,
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '로그인',
                            style: AppTypography.headline2.copyWith(
                              color: AppColors.background,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.arrow_forward,
                            color: AppColors.background,
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildHelperLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTextButton(
          text: '계정 찾기',
          onPressed: () => context.push('/find-account'),
        ),
        Text('|', style: TextStyle(color: Colors.white.withValues(alpha: 0.1))),
        _buildTextButton(
          text: '회원가입',
          onPressed: () => context.push('/signup'),
        ),
      ],
    );
  }

  Widget _buildTextButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: AppTypography.body2.copyWith(
          color: AppColors.textDim,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSocialLoginSection() {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider(color: Colors.white10)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '소셜 계정으로 계속하기',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textDim,
                  fontSize: 8,
                ),
              ),
            ),
            const Expanded(child: Divider(color: Colors.white10)),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton('google'),
            const SizedBox(width: 16),
            _buildSocialButton('discord'),
            const SizedBox(width: 16),
            _buildSocialButton('apple'),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton(String type) {
    // Determine the signal based on the button type
    late final Signal<bool> isHovering;
    if (type == 'google') {
      isHovering = _viewModel.isHoveringGoogle;
    } else if (type == 'discord') {
      isHovering = _viewModel.isHoveringDiscord;
    } else {
      isHovering = _viewModel.isHoveringApple;
    }

    return Watch((context) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => isHovering.value = true,
        onExit: (_) => isHovering.value = false,
        child: AnimatedScale(
          scale: isHovering.value ? 1.1 : 1.0,
          duration: const Duration(milliseconds: 150),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.surface.withValues(alpha: 0.6),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
              boxShadow: isHovering.value
                  ? AppColors.neonGlow(AppColors.primary)
                  : null,
            ),
            child: IconButton(
              onPressed: () {
                if (type == 'google') {
                  _viewModel.signInWithGoogle();
                } else if (type == 'discord') {
                  _viewModel.signInWithDiscord();
                } else {
                  _viewModel.signInWithApple();
                }
              },
              icon: Icon(
                type == 'google'
                    ? Icons.g_mobiledata
                    : type == 'discord'
                    ? Icons.discord
                    : Icons.apple,
                color: Colors.white70,
                size: 28,
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildFooter() {
    return Text(
      'V.2.0.4.5 // SECURE CONNECTION',
      style: GoogleFonts.shareTechMono(
        color: AppColors.textDim,
        fontSize: 10,
        letterSpacing: 1,
      ),
    );
  }
}
