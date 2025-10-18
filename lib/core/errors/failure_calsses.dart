
import 'failure.dart';

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.statusCode,
    super.errorCode,
    super.details,
  });

  factory ServerFailure.fromStatusCode(
    int statusCode, {
    String? message,
    Map<String, dynamic>? details,
  }) {
    switch (statusCode) {
      case 400:
        return ServerFailure(
          message: message ?? 'Bad request. Please check your input.',
          statusCode: statusCode,
          errorCode: 'BAD_REQUEST',
          details: details,
        );
      case 401:
        return ServerFailure(
          message: message ?? 'Unauthorized. Please login again.',
          statusCode: statusCode,
          errorCode: 'UNAUTHORIZED',
          details: details,
        );
      case 403:
        return ServerFailure(
          message: message ?? 'Access forbidden.',
          statusCode: statusCode,
          errorCode: 'FORBIDDEN',
          details: details,
        );
      case 404:
        return ServerFailure(
          message: message ?? 'Resource not found.',
          statusCode: statusCode,
          errorCode: 'NOT_FOUND',
          details: details,
        );
      case 422:
        return ServerFailure(
          message: message ?? 'Validation failed.',
          statusCode: statusCode,
          errorCode: 'VALIDATION_ERROR',
          details: details,
        );
      case 429:
        return ServerFailure(
          message: message ?? 'Too many requests. Please try again later.',
          statusCode: statusCode,
          errorCode: 'RATE_LIMIT',
          details: details,
        );
      case 500:
        return ServerFailure(
          message: message ?? 'Internal server error. Please try again later.',
          statusCode: statusCode,
          errorCode: 'INTERNAL_ERROR',
          details: details,
        );
      default:
        return ServerFailure(
          message: message ?? 'Server error occurred.',
          statusCode: statusCode,
          errorCode: 'UNKNOWN_SERVER_ERROR',
          details: details,
        );
    }
  }
}

// Network-related failures
class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    super.errorCode,
    super.details,
  });

  factory NetworkFailure.noConnection() {
    return const NetworkFailure(
      message: 'No internet connection. Please check your network.',
      errorCode: 'NO_CONNECTION',
    );
  }

  factory NetworkFailure.timeout() {
    return const NetworkFailure(
      message: 'Request timeout. Please try again.',
      errorCode: 'TIMEOUT',
    );
  }

  factory NetworkFailure.connectionError() {
    return const NetworkFailure(
      message: 'Connection error. Please check your internet.',
      errorCode: 'CONNECTION_ERROR',
    );
  }
}

// Validation-related failures
class ValidationFailure extends Failure {
  final Map<String, List<String>>? fieldErrors;

  const ValidationFailure({
    required super.message,
    this.fieldErrors,
    super.errorCode,
    super.details,
  });

  factory ValidationFailure.fromFieldErrors(
    Map<String, List<String>> fieldErrors,
  ) {
    final errorMessages = <String>[];
    fieldErrors.forEach((field, messages) {
      errorMessages.addAll(messages.map((msg) => '• $msg'));
    });

    return ValidationFailure(
      message: errorMessages.join('\n'),
      fieldErrors: fieldErrors,
      errorCode: 'VALIDATION_ERROR',
    );
  }

  List<String> getFieldErrors(String field) {
    return fieldErrors?[field] ?? [];
  }

  bool hasFieldError(String field) {
    return fieldErrors?.containsKey(field) ?? false;
  }

  @override
  List<Object?> get props => [...super.props, fieldErrors];
}

// Authentication-related failures
class AuthFailure extends Failure {
  const AuthFailure({
    required super.message,
    super.errorCode,
    super.details,
  });

  factory AuthFailure.invalidCredentials() {
    return const AuthFailure(
      message: 'Invalid email or password.',
      errorCode: 'INVALID_CREDENTIALS',
    );
  }

  factory AuthFailure.emailAlreadyExists() {
    return const AuthFailure(
      message: 'Email already exists. Please use a different email.',
      errorCode: 'EMAIL_EXISTS',
    );
  }

  factory AuthFailure.sessionExpired() {
    return const AuthFailure(
      message: 'Session expired. Please login again.',
      errorCode: 'SESSION_EXPIRED',
    );
  }
}

// Cache-related failures
class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.errorCode,
    super.details,
  });

  factory CacheFailure.notFound() {
    return const CacheFailure(
      message: 'Data not found in cache.',
      errorCode: 'CACHE_NOT_FOUND',
    );
  }

  factory CacheFailure.writeError() {
    return const CacheFailure(
      message: 'Failed to save data to cache.',
      errorCode: 'CACHE_WRITE_ERROR',
    );
  }
}

// Unknown/Generic failures
class UnknownFailure extends Failure {
  const UnknownFailure({
    required super.message,
    super.errorCode,
    super.details,
  });

  factory UnknownFailure.fromException(Exception exception) {
    return UnknownFailure(
      message: 'An unexpected error occurred: ${exception.toString()}',
      errorCode: 'UNKNOWN_ERROR',
      details: {'exception': exception.toString()},
    );
  }
}