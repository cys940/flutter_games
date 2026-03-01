import '../entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getProfile(String userId);
  Future<void> updateProfile({
    required String userId,
    String? username,
    String? fullName,
    String? avatarUrl,
  });
}
