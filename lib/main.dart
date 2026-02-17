import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/design_system/styles.dart';
import 'core/di/injection.dart';
import 'core/router/app_router.dart';

void main() async {
  // 1. 위젯 바인딩 초기화
  WidgetsFlutterBinding.ensureInitialized();
  
  // 2. 환경 변수 로드 (.env)
  await dotenv.load(fileName: '.env');

  // 3. Supabase 초기화
  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_ANON_KEY'),
  );
  
  // 4. 의존성 주입(DI) 자동화 초기화
  configureDependencies();

  // 5. 앱 실행
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
