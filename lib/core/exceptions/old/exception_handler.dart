// import 'package:aviz/core/exceptions/error_messages.dart';
// import 'package:dio/dio.dart';
// import 'api_exception.dart';
//
// class ExceptionHandler {
//   call(DioException dioException, {ErrorMessages? messages}) {
//     if (dioException.type == DioExceptionType.badResponse &&
//         dioException.response != null) {
//       _handleResponse(dioException.response!, messages: messages);
//     } else {
//       throw NetworkException();
//     }
//   }
// }
//
// dynamic _handleResponse(Response response, {ErrorMessages? messages}) {
//   switch (response.statusCode) {
//     case 200 || 201:
//       return response;
//     case 401:
//       throw UnauthorisedException();
//     case 403:
//       throw ForbiddenException(
//           message: messages?.forbidden ?? response.data['message']);
//     case 404:
//       throw NotFoundException(
//           message: messages?.notFound ?? response.data['message']);
//     case 500:
//       throw ServerException();
//     default:
//       throw UnknownException();
//   }
// }
