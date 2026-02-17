import 'package:flutter/material.dart';

import 'core/design_system/styles.dart';
import 'core/di/injection.dart';
import 'core/router/app_router.dart';

void main() {
  // 1. 위젯 바인딩 초기화
  WidgetsFlutterBinding.ensureInitialized();
  
  // 2. 의존성 주입(DI) 자동화 초기화
  configureDependencies();

  // 3. 앱 실행
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Clean Game',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.surface,
          error: AppColors.error,
        ),
      ),
      // AppRouter를 통한 라우팅 설정
      routerConfig: AppRouter.router,
    );
  }
}
