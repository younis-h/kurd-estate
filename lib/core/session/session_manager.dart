import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

class SessionManager {
  final SupabaseClient _supabase;

  SessionManager(this._supabase);

  User? get currentUser => _supabase.auth.currentUser;

  Session? get currentSession => _supabase.auth.currentSession;

  bool get isSignedIn => currentUser != null;

  Stream<AuthState> get authStateChanges =>
      _supabase.auth.onAuthStateChange;

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}