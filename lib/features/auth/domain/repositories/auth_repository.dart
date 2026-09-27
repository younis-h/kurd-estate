import '../entities/user_entity.dart';

abstract interface class AuthRepository {
  Future<UserEntity?> getCurrentUser();

  Future<UserEntity> signIn({
    required String email,
    required String password,
  });

  Future<UserEntity> signUp({
    required String email,
    required String password,
    required String fullName,
  });

  Future<void> signOut();

  Future<void> resetPassword({
    required String email,
  });

  Future<bool> isSignedIn();
}