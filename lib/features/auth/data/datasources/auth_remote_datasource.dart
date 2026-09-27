import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSource {
  final SupabaseClient _client;

  const AuthRemoteDataSource(this._client);

  User? getCurrentUser() {
    return _client.auth.currentUser;
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) {
    return _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String fullName,
  }) {
    return _client.auth.signUp(
      email: email,
      password: password,
      data: {
        'full_name': fullName,
      },
    );
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  Future<void> resetPassword({
    required String email,
  }) async {
    await _client.auth.resetPasswordForEmail(email);
  }

  bool isSignedIn() {
    return _client.auth.currentUser != null;
  }
}