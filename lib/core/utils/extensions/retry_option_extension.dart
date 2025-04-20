import 'package:dio/dio.dart';

extension RetryOptionExtension on Options {
  Options enableRetry() {
    extra = extra ?? {};
    extra!['retry'] = true;
    return this;
  }
}
