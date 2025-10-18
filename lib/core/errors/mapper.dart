import 'package:dio/dio.dart';

import 'failure.dart';
import 'failure_calsses.dart';


class FailureMapper {
  FailureMapper._();

  /// Convert DioException to appropriate Failure
  static Failure fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkFailure.timeout();

      case DioExceptionType.connectionError:
        return NetworkFailure.connectionError();

      case DioExceptionType.badResponse:
        return _handleBadResponse(e);

      case DioExceptionType.cancel:
        return const NetworkFailure(
          message: 'Request was cancelled.',
          errorCode: 'REQUEST_CANCELLED',
        );

      default:
        return NetworkFailure.connectionError();
    }
  }

  static Failure _handleBadResponse(DioException e) {
    final statusCode = e.response?.statusCode ?? 0;
    final responseData = e.response?.data;

    print('🔍 FailureMapper - Response status: $statusCode');
    print('🔍 FailureMapper - Response data: $responseData');
    print('🔍 FailureMapper - Response data type: ${responseData.runtimeType}');

    // Try to extract error details from response
    String? message;
    Map<String, List<String>>? fieldErrors;
    Map<String, dynamic>? details;

    if (responseData is Map<String, dynamic>) {
      message = responseData['message'] as String?;
      details = responseData;

      print('🔍 FailureMapper - Extracted message: $message');

      // Handle the errors object from your API response
      if (responseData.containsKey('errors') &&
          responseData['errors'] is Map<String, dynamic>) {
        final errors = responseData['errors'] as Map<String, dynamic>;
        fieldErrors = <String, List<String>>{};

        print('🔍 FailureMapper - Processing errors: $errors');

        errors.forEach((key, value) {
          if (value is List) {
            fieldErrors![key] = value.map((item) => item.toString()).toList();
          } else if (value is String) {
            fieldErrors![key] = [value];
          }

          print(
            '🔍 FailureMapper - Added field error: $key -> ${fieldErrors![key]}',
          );
        });

        print('🔍 FailureMapper - Final fieldErrors: $fieldErrors');
      }
    }

    // IMPORTANT: Check for validation errors first, regardless of status code
    if (fieldErrors != null && fieldErrors.isNotEmpty) {
      print(
        '🎯 FailureMapper - Creating ValidationFailure with fields: $fieldErrors',
      );
      return ValidationFailure.fromFieldErrors(fieldErrors);
    }

    // Handle authentication errors
    if (statusCode == 401) {
      return AuthFailure.invalidCredentials();
    }

    // Handle other server errors
    print('🎯 FailureMapper - Creating ServerFailure');
    return ServerFailure.fromStatusCode(
      statusCode,
      message: message,
      details: details,
    );
  }

  /// Convert generic Exception to Failure
  static Failure fromException(Exception e) {
    if (e is DioException) {
      return fromDioException(e);
    }
    return UnknownFailure.fromException(e);
  }

  /// Convert any error to Failure
  static Failure fromError(dynamic error) {
    if (error is Failure) {
      return error;
    } else if (error is Exception) {
      return fromException(error);
    } else {
      return UnknownFailure(
        message: 'An unexpected error occurred: ${error.toString()}',
        errorCode: 'UNKNOWN_ERROR',
        details: {'originalError': error.toString()},
      );
    }
  }
}