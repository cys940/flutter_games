import 'package:injectable/injectable.dart';
import 'package:signals_flutter/signals_flutter.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';

@injectable
class ProfileViewModel {
  ProfileViewModel(this._repository);
  final ProfileRepository _repository;

  final profile = signal<ProfileEntity?>(null);
  final isLoading = signal<bool>(false);
  final isEditing = signal<bool>(false);
  final errorMessage = signal<String?>(null);
  final usernameInput = signal<String>('');
  final fullNameInput = signal<String>('');

  Future<void> loadProfile(String userId) async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final p = await _repository.getProfile(userId);
      profile.value = p;
      usernameInput.value = p.username;
      fullNameInput.value = p.fullName;
    } catch (e) {
      errorMessage.value = '프로필을 불러오지 못했습니다.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveProfile(String userId) async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      await _repository.updateProfile(
        userId: userId,
        username: usernameInput.value.trim(),
        fullName: fullNameInput.value.trim(),
      );
      await loadProfile(userId);
      isEditing.value = false;
    } catch (e) {
      errorMessage.value = '프로필 저장에 실패했습니다.';
    } finally {
      isLoading.value = false;
    }
  }

  void toggleEdit() => isEditing.value = !isEditing.value;
}
