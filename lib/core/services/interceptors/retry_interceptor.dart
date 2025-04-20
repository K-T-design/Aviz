import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logger/logger.dart';
//
// class RetryInterceptor extends Interceptor {
//   final Dio dio;
//   final Connectivity connectivity;
//
//   RetryInterceptor({required this.dio, required this.connectivity});
//
//   @override
//   Future onError(DioException err, ErrorInterceptorHandler handler) async {
//     if (_shouldRetry(err)) {
//       Logger().w('No internet, retrying request when connected...');
//
//       await _waitForInternet();
//
//       try {
//         final response = await dio.fetch(err.requestOptions);
//         return handler.resolve(response);
//       } catch (e) {
//         return handler.reject(err);
//       }
//     }
//
//     return handler.next(err);
//   }
//
//   bool _shouldRetry(DioException err) {
//     if (err.requestOptions.extra['retry'] == false) return false;
//     return err.type == DioExceptionType.connectionError ||
//         err.type == DioExceptionType.unknown;
//   }
//
//   Future<void> _waitForInternet() async {
//     StreamSubscription? subscription;
//     final completer = Completer<void>();
//
//     subscription = connectivity.onConnectivityChanged.listen((results) {
//       if (results.isNotEmpty &&
//           results.any((r) => r != ConnectivityResult.none)) {
//         completer.complete();
//         subscription?.cancel();
//       }
//     });
//
//     return completer.future;
//   }
// }

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final Connectivity connectivity;

  RetryInterceptor({
    required this.dio,
    required this.connectivity,
  });

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      Logger().w('No internet, retrying request when connected...');

      await _waitForInternet();

      try {
        final response = await dio.fetch(err.requestOptions);
        return handler.resolve(response);
      } catch (e) {
        return handler.reject(err);
      }
    }
    return handler.next(err);
  }

  bool _shouldRetry(DioException err) {
    if (err.requestOptions.extra['retry'] == false) return false;
    return err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.unknown ||
        err.error is SocketException;
  }

  Future<void> _waitForInternet() async {
    StreamSubscription? subscription;
    final completer = Completer<void>();

    subscription = connectivity.onConnectivityChanged.listen((results) {
      if (results.isNotEmpty &&
          results.any((r) => r != ConnectivityResult.none)) {
        completer.complete();
        subscription?.cancel();
      }
    });

    return completer.future;
  }

  // Future<void> _waitForInternet() async {
  //   final completer = Completer<void>();
  //   late StreamSubscription sub;
  //
  //   sub = connectivity.onConnectivityChanged.listen((results) async {
  //     if (results.isNotEmpty &&
  //         results.any((r) => r != ConnectivityResult.none)) {
  //       completer.complete();
  //       sub.cancel();
  //     }
  //   });
  //
  //   // Force cleanup after timeout
  //   Future.delayed(const Duration(minutes: 5)).then((_) {
  //     if (!completer.isCompleted) {
  //       completer.completeError('Timeout');
  //       sub.cancel();
  //     }
  //   });
  //
  //   return completer.future;
  // }
}
