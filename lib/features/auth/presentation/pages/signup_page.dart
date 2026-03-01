import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/design_system/styles.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/layouts/responsive_layout.dart';
import '../viewmodels/login_view_model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _viewModel = getIt<LoginViewModel>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _fullNameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameController.dispose();
    _fullNameController.dispose();
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
            child: _buildAmbientGlow(AppColors.secondary.withValues(alpha: 0.1), glowSize1),
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
                              horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Colors.red.withValues(alpha: 0.3)),
                          ),
                          child: Text(
                            error,
                            style: const TextStyle(
                                color: Colors.redAccent, fontSize: 12),
                          ),
                        );
                      }),
                      const SizedBox(height: 24),
                      _buildSignUpButton(),
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
        Text(
          '신규 가입',
          style: AppTypography.headline1.copyWith(
            fontSize: 32,
            color: AppColors.secondary,
            shadows: [
              Shadow(
                color: AppColors.secondary.withValues(alpha: 0.5),
                blurRadius: 8,
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '계정 프로필 생성',
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
        _buildLabel('사용자 이름 (ID)'),
        const SizedBox(height: 8),
        _buildTextField(
          controller: _usernameController,
          hintText: '고유한 사용자 이름을 입력하세요',
          icon: Icons.alternate_email,
        ),
        const SizedBox(height: 20),
        _buildLabel('이름 (실명)'),
        const SizedBox(height: 8),
        _buildTextField(
          controller: _fullNameController,
          hintText: '실명을 입력하세요',
          icon: Icons.person_outline,
        ),
        const SizedBox(height: 20),
        _buildLabel('이메일 주소'),
        const SizedBox(height: 8),
        _buildTextField(
          controller: _emailController,
          hintText: '이메일을 입력하세요',
          icon: Icons.email_outlined,
        ),
        const SizedBox(height: 20),
        _buildLabel('비밀번호'),
        const SizedBox(height: 8),
        Watch((context) => _buildTextField(
          controller: _passwordController,
          hintText: '비밀번호를 설정하세요',
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
        )),
        const SizedBox(height: 20),
        _buildLabel('비밀번호 확인'),
        const SizedBox(height: 8),
        Watch((context) => _buildTextField(
          controller: _confirmPasswordController,
          hintText: '비밀번호를 다시 입력하세요',
          icon: Icons.lock_reset,
          obscureText: !_viewModel.isPasswordVisible.value,
        )),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text,
        style: AppTypography.caption.copyWith(
          color: AppColors.secondary.withValues(alpha: 0.8),
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
              style: AppTypography.body1,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTypography.body2.copyWith(color: AppColors.textDim),
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

  Widget _buildSignUpButton() {
    return Watch((context) {
      final isLoading = _viewModel.isLoading.value;
      return GestureDetector(
        onTap: isLoading ? null : _handleSignUp,
        child: MouseRegion(
          cursor: isLoading ? SystemMouseCursors.basic : SystemMouseCursors.click,
          child: Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              boxShadow: AppColors.neonGlow(AppColors.secondary),
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: isLoading
                    ? [
                        AppColors.secondary.withValues(alpha: 0.5),
                        AppColors.secondary.withValues(alpha: 0.5)
                      ]
                    : [AppColors.secondary, const Color(0xFFE044FF)],
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
                          '프로필 생성하기',
                          style: AppTypography.headline2.copyWith(
                            color: AppColors.background,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.rocket_launch,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '이미 계정이 있으신가요?',
          style: AppTypography.body2.copyWith(color: AppColors.textDim),
        ),
        TextButton(
          onPressed: () => context.pop(),
          child: Text(
            '로그인',
            style: AppTypography.body2.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleSignUp() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showError('이메일과 비밀번호는 필수 입력 항목입니다.');
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showError('비밀번호가 일치하지 않습니다.');
      return;
    }

    if (_usernameController.text.length < 3) {
      _showError('사용자 이름은 최소 3자 이상이어야 합니다.');
      return;
    }

    await _viewModel.signUp(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      username: _usernameController.text.trim(),
      fullName: _fullNameController.text.trim(),
    );

    if (_viewModel.errorMessage.value != null) {
      _showError(_viewModel.errorMessage.value!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('회원가입이 완료되었습니다! 이메일 인증을 확인해 주세요.'),
            backgroundColor: Colors.green,
          ),
        );
        context.pop();
      }
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
