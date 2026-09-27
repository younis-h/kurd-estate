import 'exceptions.dart';
import 'failures.dart';

class ErrorHandler {
  ErrorHandler._();

  static Failure handle(Object error) {
    if (error is NetworkException) {
      return const NetworkFailure();
    }

    if (error is ServerException) {
      return const ServerFailure();
    }

    if (error is CacheException) {
      return const CacheFailure();
    }

    if (error is UnauthorizedException) {
      return const UnauthorizedFailure();
    }

    if (error is ValidationException) {
      return const ValidationFailure();
    }

    return const UnknownFailure();
  }
}