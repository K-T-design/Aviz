import 'api_exception.dart';

/// Utility class that simplifies handling errors.
///
/// Return a [Result] from a function to indicate success or failure.
///
/// A [Result] is either an [Ok] with a value of type [T]
/// or an [Error] with an [Exception].
///
/// Use [Result.ok] to create a successful result with a value of type [T].
/// Use [Result.error] to create an error result with an [Exception].
sealed class Result<T> {
  const Result();

  factory Result.ok(T value) => Ok(value);
  factory Result.error(ApiException error) => Error(error);

  Ok<T> get asOk {
    if (this is Ok<T>) return this as Ok<T>;
    throw StateError('Cannot access asOk on an Error result');
  }

  Error<T> get asError {
    if (this is Error<T>) return this as Error<T>;
    throw StateError('Cannot access asError on an Ok result');
  }

  void when({
    required void Function(T data) ok,
    required void Function(ApiException error) error,
  }) {
    switch (this) {
      case Ok<T>(value: final value):
        ok(value);
        break;
      case Error<T>(error: final exception):
        error(exception);
        break;
    }
  }
}

final class Ok<T> extends Result<T> {
  const Ok(this.value);

  final T value;
}

final class Error<T> extends Result<T> {
  const Error(this.error);

  final ApiException error;
}
