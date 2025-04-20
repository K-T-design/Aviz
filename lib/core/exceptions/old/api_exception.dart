// import 'package:aviz/core/exceptions/error_messages.dart';
//
// class ApiException implements Exception {
//   final String message;
//   final int? statusCode;
//   final ErrorCode? errorCode;
//
//   ApiException(
//     this.message, {
//     this.statusCode,
//     this.errorCode,
//   });
// }
//
// class ServerException extends ApiException {
//   ServerException({String? message})
//       : super(
//           statusCode: 500,
//           message ?? "مشکلی پیش آمده لطفا بعدا امتحان کنید",
//         );
// }
//
// class NetworkException extends ApiException {
//   NetworkException({String? message})
//       : super(message ?? "اتصال اینترنت خود را بررسی کنید");
// }
//
// class ForbiddenException extends ApiException {
//   ForbiddenException({String? message})
//       : super(
//           statusCode: 403,
//           message ?? "عملیات موردنظر امکان پذیر نیست",
//         );
// }
//
// class NotFoundException extends ApiException {
//   NotFoundException({String? message})
//       : super(
//           statusCode: 404,
//           message ?? "صفحه مورد نظر یافت نشد",
//         );
// }
//
// class UnauthorisedException extends ApiException {
//   UnauthorisedException({String? message})
//       : super(
//           statusCode: 401,
//           message ?? "",
//         );
// }
//
// class UnknownException extends ApiException {
//   UnknownException({String? message})
//       : super(message ?? "مشکلی پیش آمده لطفا بعدا امتحان کنید");
// }
