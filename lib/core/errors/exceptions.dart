abstract class AppException implements Exception {
  final String message;

  const AppException(this.message);

  @override
  String toString() => message;
}

class ServerException extends AppException {
  const ServerException([super.message = 'Server Error']);
}

class CacheException extends AppException {
  const CacheException([super.message = 'Cache Error']);
}

class NetworkException extends AppException {
  const NetworkException([super.message = 'No Internet Connection']);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([super.message = 'Unauthorized']);
}

class NotFoundException extends AppException {
  const NotFoundException([super.message = 'Resource Not Found']);
}

class ValidationException extends AppException {
  const ValidationException([super.message = 'Validation Error']);
}