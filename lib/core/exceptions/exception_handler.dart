import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import 'api_exception.dart';

class ExceptionHandler {
  static final _defaultMessages = {
    401: "Unauthorized",
    403: "Forbidden",
    404: "Not Found",
    500: 'مشکلی پیش آمده، لطفا بعدا امتحان کنید',
  };

  ApiException call(DioException e, {Map<String, String>? messages}) {
    if (e.response == null ||
        e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.error is SocketException) {
      Logger().e("Internet DioException: ${e.type}");

      return ApiException("اتصال اینترنت خود را بررسی کنید");
    }

    Logger().e(e.message);

    final data = e.response!.data as Map<String, dynamic>?;
    final statusCode = e.response!.statusCode;
    final errorCode = data?['errorCode'] as String?;
    final apiMessage = data?['message'] as String?;

    final message = messages?[
            errorCode] ?? //customMessages?[statusCode]?? _defaultMessages[statusCode]
        apiMessage ??
        _defaultMessages[statusCode] ??
        'مشکلی پیش آمده، لطفا بعدا امتحان کنید';

    return ApiException(
      message,
      statusCode: statusCode,
      errorCode: errorCode,
    );
  }
}
