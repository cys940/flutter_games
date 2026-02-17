import 'package:injectable/injectable.dart';
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
    } catch (e) {
      errorMessage.value = '로그인 실패: 이메일 또는 비밀번호를 확인해 주세요.';
    } finally {
      isLoading.value = false;
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
