import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signals_flutter/signals_flutter.dart';
import '../../../../core/design_system/styles.dart';
import '../../../../core/di/injection.dart';
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
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Ambient Glow Effects
          Positioned(
            top: -100,
            right: -100,
            child: _buildAmbientGlow(AppColors.primary.withValues(alpha: 0.1), 300),
          ),
          Positioned(
            bottom: -80,
            left: -80,
            child: _buildAmbientGlow(AppColors.primary.withValues(alpha: 0.05), 250),
          ),

          // Main Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      _buildHeader(),
                      const SizedBox(height: 40),
                      _buildInputSection(),
                      const SizedBox(height: 24),
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
          'SYSTEM ACCESS',
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
        _buildLabel('ID / USERNAME'),
        const SizedBox(height: 8),
        _buildTextField(
          controller: _emailController,
          hintText: 'Enter your ID',
          icon: Icons.person_outline,
          onChanged: (value) => _viewModel.email.value = value,
        ),
        const SizedBox(height: 20),
        _buildLabel('PASSWORD'),
        const SizedBox(height: 8),
        Watch((context) => _buildTextField(
          controller: _passwordController,
          hintText: 'Enter your password',
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
                hintStyle: AppTypography.body2.copyWith(color: AppColors.textDim),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          if (suffixIcon != null) suffixIcon,
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return Watch((context) {
      final isLoading = _viewModel.isLoading.value;
      return Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          boxShadow: AppColors.neonGlow(AppColors.primary),
        ),
        child: ElevatedButton(
          onPressed: isLoading ? null : _viewModel.login,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
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
                      'LOGIN',
                      style: AppTypography.headline2.copyWith(
                        color: AppColors.background,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward),
                  ],
                ),
        ),
      );
    });
  }

  Widget _buildHelperLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTextButton('Find Account'),
        Text('|', style: TextStyle(color: Colors.white.withValues(alpha: 0.1))),
        _buildTextButton('Sign Up'),
      ],
    );
  }

  Widget _buildTextButton(String text) {
    return TextButton(
      onPressed: () {},
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
                'OR CONTINUE WITH',
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
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.6),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          type == 'google' ? Icons.g_mobiledata : 
          type == 'discord' ? Icons.discord : Icons.apple,
          color: Colors.white70,
          size: 28,
        ),
      ),
    );
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
