import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:signals_flutter/signals_flutter.dart';
import '../../domain/repositories/auth_repository.dart';

@injectable
class LoginViewModel {
  LoginViewModel(this._authRepository);

  final AuthRepository _authRepository;

  late final email = signal<String>('');
  late final password = signal<String>('');
  late final isLoading = signal<bool>(false);
  late final errorMessage = signal<String?>(null);
  late final isPasswordVisible = signal<bool>(false);
  late final isHoveringLogin = signal<bool>(false);
  late final isHoveringGoogle = signal<bool>(false);
  late final isHoveringDiscord = signal<bool>(false);
  late final isHoveringApple = signal<bool>(false);

  Future<void> login() async {
    if (email.value.isEmpty || password.value.isEmpty) {
      errorMessage.value = '이메일과 비밀번호를 입력해 주세요.';
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;

    try {
      await _authRepository.signInWithEmail(
        email: email.value.trim(),
        password: password.value,
      );
    } on AuthException catch (e) {
      if (e.message.toLowerCase().contains('email not confirmed')) {
        errorMessage.value = '이메일 인증이 완료되지 않았습니다. 이메일을 확인해 주세요.';
      } else if (e.message.toLowerCase().contains('invalid login credentials')) {
        errorMessage.value = '이메일 또는 비밀번호가 올바르지 않습니다.';
      } else {
        errorMessage.value = '로그인 실패: ${e.message}';
      }
    } catch (e) {
      errorMessage.value = '로그인 중 오류가 발생했습니다.';
    } finally {
      isLoading.value = false;
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> signInWithGoogle() => _authRepository.signInWithOAuth(OAuthProvider.google);
  Future<void> signInWithDiscord() => _authRepository.signInWithOAuth(OAuthProvider.discord);
  Future<void> signInWithApple() => _authRepository.signInWithOAuth(OAuthProvider.apple);

  late final username = signal<String>('');
  late final fullName = signal<String>('');

  Future<void> signUp({
    required String email,
    required String password,
    String? username,
    String? fullName,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      errorMessage.value = '이메일과 비밀번호를 입력해 주세요.';
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;

    try {
      await _authRepository.signUp(
        email: email,
        password: password,
        // Pass metadata for the Postgres trigger to create a profile
        data: {
          if (username != null) 'user_name': username,
          if (fullName != null) 'full_name': fullName,
        },
      );
    } on AuthException catch (e) {
      if (e.message.contains('User already registered')) {
        errorMessage.value = '이미 등록된 이메일입니다.';
      } else {
        errorMessage.value = '회원가입 실패: ${e.message}';
      }
    } catch (e) {
      errorMessage.value = '회원가입 중 오류가 발생했습니다.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword(String email) async {
    isLoading.value = true;
    try {
      await _authRepository.resetPassword(email);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() => _authRepository.signOut();

  User? get currentUser => _authRepository.currentUser;
}
