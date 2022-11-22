abstract class BaseException implements Exception {
  BaseException({
    required this.message,
    this.stackTrace,
    this.code,
  });

  final String message;
  final dynamic stackTrace;
  final int? code;

  @override
  String toString() {
    return message;
  }
}
