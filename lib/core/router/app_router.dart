import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/viewmodels/home_view_model.dart';
import '../../features/shooter/presentation/pages/shooter_page.dart';
import '../../features/shooter/presentation/viewmodels/shooter_view_model.dart';
import '../di/injection.dart';

/// 앱 전체의 라우팅 설정을 관리하는 클래스입니다.
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
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
    ],
    // 네비게이션 에러 처리 (선택 사항)
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('No route defined for ${state.uri}'),
      ),
    ),
  );
}
