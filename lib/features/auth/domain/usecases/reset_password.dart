import '../repositories/auth_repository.dart';

class ResetPassword {
  final AuthRepository _repository;

  const ResetPassword(this._repository);

  Future<void> call({
    required String email,
  }) {
    return _repository.resetPassword(
      email: email,
    );
  }
}