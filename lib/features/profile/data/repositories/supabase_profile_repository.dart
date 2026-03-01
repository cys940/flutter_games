import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';

@LazySingleton(as: ProfileRepository)
class SupabaseProfileRepository implements ProfileRepository {
  SupabaseProfileRepository(this._supabase);
  final SupabaseClient _supabase;

  @override
  Future<ProfileEntity> getProfile(String userId) async {
    final data = await _supabase
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();
    return ProfileEntity(
      id: data['id'] as String,
      username: (data['username'] as String?) ?? '',
      fullName: (data['full_name'] as String?) ?? '',
      avatarUrl: data['avatar_url'] as String?,
      website: data['website'] as String?,
      updatedAt: data['updated_at'] != null
          ? DateTime.parse(data['updated_at'] as String)
          : null,
    );
  }

  @override
  Future<void> updateProfile({
    required String userId,
    String? username,
    String? fullName,
    String? avatarUrl,
  }) async {
    final updates = <String, dynamic>{
      'updated_at': DateTime.now().toIso8601String(),
      ?if (username != null) 'username': username,
      ?if (fullName != null) 'full_name': fullName,
      ?if (avatarUrl != null) 'avatar_url': avatarUrl,
    };
    await _supabase.from('profiles').update(updates).eq('id', userId);
  }
}
