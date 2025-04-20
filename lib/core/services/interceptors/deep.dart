import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class ConnectionWatcher {
  static final ConnectionWatcher _instance = ConnectionWatcher._internal();
  factory ConnectionWatcher() => _instance;
  ConnectionWatcher._internal();

  final Connectivity _connectivity = Connectivity();
  Completer<bool>? _completer;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  Future<bool> waitForConnection() async {
    if (_completer != null) return _completer!.future;

    _completer = Completer<bool>();

    _subscription = _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      if (_hasConnection(results)) {
        _completer?.complete(true);
        _reset();
      }
    });

    final currentStatus = await _connectivity.checkConnectivity();
    if (_hasConnection(currentStatus)) {
      _completer?.complete(true);
      _reset();
    }

    return _completer!.future;
  }

  bool _hasConnection(List<ConnectivityResult> results) {
    return !results.contains(ConnectivityResult.none);
  }

  void _reset() {
    _subscription?.cancel();
    _subscription = null;
    _completer = null;
  }
}

// Step 2: Retry Interceptor
class DeepRetryInterceptor extends Interceptor {
  final Dio dio;
  final ConnectionWatcher connectionWatcher = ConnectionWatcher();

  DeepRetryInterceptor(this.dio);

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      try {
        await connectionWatcher.waitForConnection();
        final response = await dio.fetch(err.requestOptions);
        handler.resolve(response);
      } catch (e) {
        handler.reject(err);
      }
    } else {
      handler.reject(err);
    }
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout ||
        err.error is SocketException;
  }
}

//////

// class ConnectionStatus {
//   static final ConnectionStatus _instance = ConnectionStatus._internal();
//   factory ConnectionStatus() => _instance;
//   ConnectionStatus._internal() {
//     _init();
//   }
//
//   final Connectivity _connectivity = Connectivity();
//   bool _isConnected = true;
//   final _connectionStream = StreamController<bool>.broadcast();
//
//   Stream<bool> get connectionStream => _connectionStream.stream;
//
//   Future<void> _init() async {
//     // Initial check
//     _checkStatus(await _connectivity.checkConnectivity());
//
//     // Listen for changes
//     _connectivity.onConnectivityChanged.listen(_checkStatus);
//   }
//
//   Future<void> _checkStatus(List<ConnectivityResult> results) async {
//     final newStatus = !results.contains(ConnectivityResult.none);
//     if (newStatus != _isConnected) {
//       _isConnected = newStatus;
//       _connectionStream.add(_isConnected);
//     }
//   }
// }
//
// class DeepRetryInterceptor extends Interceptor {
//   final Dio dio;
//   final ConnectionStatus _connectionStatus = ConnectionStatus();
//   final _failedRequests = <RequestOptions>[];
//
//   DeepRetryInterceptor(this.dio) {
//     _connectionStatus.connectionStream.listen((isConnected) {
//       if (isConnected) _retryFailedRequests();
//     });
//   }
//
//   @override
//   Future<void> onError(
//       DioException err, ErrorInterceptorHandler handler) async {
//     if (_shouldRetry(err)) {
//       // Add to retry queue
//       _failedRequests.add(err.requestOptions);
//
//       // Propagate error immediately to show snackbar
//       handler.reject(err);
//     } else {
//       handler.reject(err);
//     }
//   }
//
//   bool _shouldRetry(DioException err) {
//     return err.type == DioExceptionType.connectionError ||
//         err.type == DioExceptionType.connectionTimeout ||
//         err.error is SocketException;
//   }
//
//   Future<void> _retryFailedRequests() async {
//     final retryQueue = List.of(_failedRequests);
//     _failedRequests.clear();
//
//     for (final requestOptions in retryQueue) {
//       try {
//         await dio.fetch(requestOptions);
//       } catch (_) {}
//     }
//   }
// }
