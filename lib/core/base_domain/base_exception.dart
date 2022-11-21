abstract class BaseException implements Exception {
  BaseException({
    required this.message,
    required this.stackTrace,
    this.code,
  });

  final String message;
  final dynamic stackTrace;
  final int? code;
}
