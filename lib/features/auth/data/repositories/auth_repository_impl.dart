import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  const AuthRepositoryImpl(this.remote);

  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = remote.getCurrentUser();

    if (user == null) {
      return null;
    }

    return UserEntity(
      id: user.id,
      email: user.email,
      fullName: user.userMetadata?['full_name'] as String?,
      phone: user.phone,
      avatarUrl: user.userMetadata?['avatar_url'] as String?,
      createdAt: DateTime.tryParse(user.createdAt),
    );
  }

  @override
  Future<UserEntity> signIn({
    required String email,
    required String password,
  }) async {
    final response = await remote.signIn(
      email: email,
      password: password,
    );

    final user = response.user!;

    return UserEntity(
      id: user.id,
      email: user.email,
      fullName: user.userMetadata?['full_name'] as String?,
      phone: user.phone,
      avatarUrl: user.userMetadata?['avatar_url'] as String?,
      createdAt: DateTime.tryParse(user.createdAt),
    );
  }

  @override
  Future<UserEntity> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    final response = await remote.signUp(
      email: email,
      password: password,
      fullName: fullName,
    );

    final user = response.user!;

    return UserEntity(
      id: user.id,
      email: user.email,
      fullName: fullName,
      phone: user.phone,
      avatarUrl: null,
      createdAt: DateTime.tryParse(user.createdAt),
    );
  }

  @override
  Future<void> signOut() {
    return remote.signOut();
  }

  @override
  Future<void> resetPassword({
    required String email,
  }) {
    return remote.resetPassword(email: email);
  }

  @override
  Future<bool> isSignedIn() async {
    return remote.isSignedIn();
  }
}