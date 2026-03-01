import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  Future<void> signInWithEmail({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  });

  Future<void> resetPassword(String email);

  Future<void> signInWithOAuth(OAuthProvider provider);

  Future<void> signOut();

  Stream<AuthState> get authStateChanges;

  User? get currentUser;
}
