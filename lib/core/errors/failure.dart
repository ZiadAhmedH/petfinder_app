import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;
  final String? errorCode;
  final Map<String, dynamic>? details;

  const Failure({
    required this.message,
    this.statusCode,
    this.errorCode,
    this.details,
  });

  @override
  List<Object?> get props => [message, statusCode, errorCode, details];

  @override
  String toString() => message;
}