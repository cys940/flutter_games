import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/signup_page.dart';
import '../../features/auth/presentation/pages/find_account_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/game_detail_page.dart';
import '../../features/home/presentation/viewmodels/home_view_model.dart';
import '../../features/shooter/presentation/pages/shooter_page.dart';
import '../../features/shooter/presentation/viewmodels/shooter_view_model.dart';
import '../../features/games/puzzle/presentation/screens/puzzle_game_screen.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/leaderboard/presentation/pages/leaderboard_page.dart';
import '../di/injection.dart';

/// 앱 전체의 라우팅 설정을 관리하는 클래스입니다.
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    // 사용자의 인증 상태 변화에 따라 라우터를 새로고침합니다.
    refreshListenable: _GoRouterRefreshStream(Supabase.instance.client.auth.onAuthStateChange),
    redirect: (context, state) {
      final authRepository = getIt<AuthRepository>();
      final isLoggedIn = authRepository.currentUser != null;
      final isAuthPath = state.uri.path == '/login' || 
                         state.uri.path == '/signup' || 
                         state.uri.path == '/find-account';
      
      if (!isLoggedIn && !isAuthPath) {
        return '/login';
      }
      if (isLoggedIn && isAuthPath) {
        return '/';
      }
      return null;
    },
    routes: [
      // 로그인 화면
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: '/find-account',
        builder: (context, state) => const FindAccountPage(),
      ),
      // 홈 화면
      GoRoute(
        path: '/',
        builder: (context, state) => HomePage(
          viewModel: getIt<HomeViewModel>(),
        ),
      ),
      // 3D 슈팅 게임 화면
      GoRoute(
        path: '/shooter',
        builder: (context, state) => ShooterPage(
          viewModel: getIt<ShooterViewModel>(),
        ),
      ),
      // 퍼즐 게임 화면 (Add this new route)
      GoRoute(
        path: '/puzzle',
        builder: (context, state) => const PuzzleGameScreen(),
      ),
      // 개별 게임 상세 화면
      GoRoute(
        path: '/game/:id',
        builder: (context, state) => GameDetailPage(
          gameId: state.pathParameters['id']!,
        ),
      ),
      // 프로필 화면
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
      // 리더보드 화면
      GoRoute(
        path: '/leaderboard',
        builder: (context, state) => const LeaderboardPage(),
      ),
    ],
    // 네비게이션 에러 처리
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('No route defined for ${state.uri}'),
      ),
    ),
  );
}

/// Supabase AuthState 변화를 GoRouter에 전달하기 위한 헬퍼 클래스
class _GoRouterRefreshStream extends ChangeNotifier {
  _GoRouterRefreshStream(Stream<AuthState> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<AuthState> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
