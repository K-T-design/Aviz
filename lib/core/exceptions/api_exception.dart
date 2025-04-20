class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? errorCode;

  ApiException(
    this.message, {
    this.statusCode,
    this.errorCode,
  });
}
