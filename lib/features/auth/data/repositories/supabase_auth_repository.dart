import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart' as gsi;
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class SupabaseAuthRepository implements AuthRepository {
  SupabaseAuthRepository(this._supabase);

  final SupabaseClient _supabase;
  bool _isGoogleInitialized = false;

  @override
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    await _supabase.auth.signInWithPassword(email: email, password: password);
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  }) async {
    await _supabase.auth.signUp(
      email: email,
      password: password,
      data: data,
      emailRedirectTo: kIsWeb ? null : 'gameapp://callback',
    );
  }

  @override
  Future<void> signInWithOAuth(OAuthProvider provider) async {
    // 1. Handle Native Google Sign-In where supported (Android, iOS, macOS, Web)
    if (provider == OAuthProvider.google) {
      final supportsNativeGoogle =
          kIsWeb || (Platform.isAndroid || Platform.isIOS || Platform.isMacOS);

      if (supportsNativeGoogle) {
        final webClientId =
            'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com'; // Placeholder
        if (webClientId.contains('YOUR_WEB_CLIENT_ID')) {
          // Fall back to browser-based OAuth if client ID is not configured
          await _supabase.auth.signInWithOAuth(
            OAuthProvider.google,
            redirectTo: kIsWeb ? null : 'gameapp://callback',
          );
          return;
        }
        if (!_isGoogleInitialized) {
          await gsi.GoogleSignIn.instance.initialize(
            serverClientId: webClientId,
          );
          _isGoogleInitialized = true;
        }
        final googleUser = await gsi.GoogleSignIn.instance.authenticate();
        final googleAuth = googleUser.authentication;
        final idToken = googleAuth.idToken;

        if (idToken != null) {
          await _supabase.auth.signInWithIdToken(
            provider: OAuthProvider.google,
            idToken: idToken,
          );
          return;
        }
      }
    }

    // 2. Default browser-based OAuth for other platforms/providers
    // On Web, redirectTo should ideally be null or the site URL.
    // On Desktop/Mobile, it should be the custom scheme.
    await _supabase.auth.signInWithOAuth(
      provider,
      redirectTo: kIsWeb ? null : 'gameapp://callback',
    );
  }

  @override
  Future<void> resetPassword(String email) async {
    await _supabase.auth.resetPasswordForEmail(
      email,
      redirectTo: kIsWeb ? null : 'gameapp://callback',
    );
  }

  @override
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  @override
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  @override
  User? get currentUser => _supabase.auth.currentUser;
}
