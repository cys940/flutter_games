import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/design_system/styles.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/layouts/responsive_layout.dart';
import '../../../auth/presentation/viewmodels/login_view_model.dart';
import '../../domain/entities/profile_entity.dart';
import '../viewmodels/profile_view_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileViewModel _vm = getIt<ProfileViewModel>();
  late final LoginViewModel _authVm = getIt<LoginViewModel>();

  late final TextEditingController _usernameCtrl;
  late final TextEditingController _fullNameCtrl;

  @override
  void initState() {
    super.initState();
    _usernameCtrl = TextEditingController();
    _fullNameCtrl = TextEditingController();
    final uid = _authVm.currentUser?.id;
    if (uid != null) _vm.loadProfile(uid);
  }

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _fullNameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildLayout(context, padding: 24, maxWidth: 480),
      tablet: _buildLayout(context, padding: 48, maxWidth: 640),
      desktop: _buildLayout(context, padding: 96, maxWidth: 860),
    );
  }

  Widget _buildLayout(
    BuildContext context, {
    required double padding,
    required double maxWidth,
  }) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            top: -60,
            right: -60,
            child: _glow(AppColors.secondary.withValues(alpha: 0.08), 260),
          ),
          Positioned(
            bottom: -60,
            left: -60,
            child: _glow(AppColors.primary.withValues(alpha: 0.05), 220),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildAppBar(context),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: padding,
                      vertical: 24,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: maxWidth),
                        child: Watch((ctx) => _buildBody(ctx)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white70,
              size: 20,
            ),
            onPressed: () => context.pop(),
          ),
          const SizedBox(width: 8),
          Text(
            '내 프로필',
            style: AppTypography.headline2.copyWith(
              color: AppColors.secondary,
              fontSize: 18,
            ),
          ),
          const Spacer(),
          Watch(
            (ctx) => _vm.isEditing.value
                ? TextButton(
                    onPressed: () {
                      final uid = _authVm.currentUser?.id;
                      if (uid == null) return;
                      _vm.usernameInput.value = _usernameCtrl.text;
                      _vm.fullNameInput.value = _fullNameCtrl.text;
                      _vm.saveProfile(uid);
                    },
                    child: Text(
                      '저장',
                      style: AppTypography.body2.copyWith(
                        color: AppColors.secondary,
                      ),
                    ),
                  )
                : TextButton(
                    onPressed: () {
                      _usernameCtrl.text = _vm.profile.value?.username ?? '';
                      _fullNameCtrl.text = _vm.profile.value?.fullName ?? '';
                      _vm.toggleEdit();
                    },
                    child: Text(
                      '편집',
                      style: AppTypography.body2.copyWith(
                        color: AppColors.textDim,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_vm.isLoading.value) {
      return const SizedBox(
        height: 300,
        child: Center(
          child: CircularProgressIndicator(color: AppColors.secondary),
        ),
      );
    }
    final p = _vm.profile.value;
    if (p == null) {
      return Center(
        child: Text(
          '프로필을 불러올 수 없습니다.',
          style: AppTypography.body1.copyWith(color: AppColors.textDim),
        ),
      );
    }
    return Column(
      children: [
        _buildAvatarSection(p),
        const SizedBox(height: 32),
        _buildInfoCard(p),
        const SizedBox(height: 24),
        _buildMyScoresSection(),
        const SizedBox(height: 32),
        _buildLogoutButton(),
      ],
    );
  }

  Widget _buildAvatarSection(ProfileEntity profile) {
    return Column(
      children: [
        Container(
          width: 88,
          height: 88,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                AppColors.secondary.withValues(alpha: 0.3),
                AppColors.primary.withValues(alpha: 0.3),
              ],
            ),
            border: Border.all(
              color: AppColors.secondary.withValues(alpha: 0.4),
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              (profile.username.isNotEmpty ? profile.username[0] : '?')
                  .toUpperCase(),
              style: AppTypography.headline1.copyWith(
                fontSize: 36,
                color: AppColors.secondary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '@${profile.username}',
          style: AppTypography.headline2.copyWith(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          profile.fullName,
          style: AppTypography.body2.copyWith(color: AppColors.textDim),
        ),
      ],
    );
  }

  Widget _buildInfoCard(ProfileEntity profile) {
    final isEditing = _vm.isEditing.value;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: Column(
            children: [
              _infoRow(
                '사용자 이름',
                isEditing
                    ? _buildInput(_usernameCtrl, '사용자 이름')
                    : Text(profile.username, style: AppTypography.body1),
              ),
              const Divider(color: Colors.white10, height: 24),
              _infoRow(
                '이름',
                isEditing
                    ? _buildInput(_fullNameCtrl, '이름')
                    : Text(profile.fullName, style: AppTypography.body1),
              ),
              const Divider(color: Colors.white10, height: 24),
              _infoRow(
                '이메일',
                Text(
                  _authVm.currentUser?.email ?? '-',
                  style: AppTypography.body1.copyWith(color: AppColors.textDim),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, Widget content) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: AppTypography.caption.copyWith(
              color: AppColors.textDim,
              fontSize: 11,
            ),
          ),
        ),
        Expanded(child: content),
      ],
    );
  }

  Widget _buildInput(TextEditingController ctrl, String hint) {
    return TextField(
      controller: ctrl,
      style: AppTypography.body1,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTypography.body2.copyWith(color: AppColors.textDim),
        border: InputBorder.none,
        isDense: true,
      ),
    );
  }

  Widget _buildMyScoresSection() {
    return Watch((ctx) {
      final myScores = _vm.profile.value;
      if (myScores == null) return const SizedBox.shrink();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Text(
              '내 최근 점수',
              style: AppTypography.caption.copyWith(
                color: AppColors.secondary.withValues(alpha: 0.8),
                fontSize: 11,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.03),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.07),
                  ),
                ),
                child: Center(
                  child: Text(
                    '게임을 플레이하면 점수가 표시됩니다',
                    style: AppTypography.body2.copyWith(
                      color: AppColors.textDim,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildLogoutButton() {
    return GestureDetector(
      onTap: () async {
        await _authVm.signOut();
        if (!context.mounted) return;
        context.go('/login');
      },
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
          color: Colors.red.withValues(alpha: 0.07),
        ),
        child: Center(
          child: Text(
            '로그아웃',
            style: AppTypography.body1.copyWith(
              color: Colors.redAccent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _glow(Color color, double size) {
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
}
