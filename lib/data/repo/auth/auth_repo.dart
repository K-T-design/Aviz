import 'package:aviz/core/exceptions/api_exception.dart';
import 'package:aviz/core/exceptions/result.dart';
import 'package:aviz/data/data_src/local/auth_local_data_src.dart';
import 'package:aviz/data/data_src/remote/auth_remote_data_src.dart';
import 'package:aviz/domain/mappers/user_mapper.dart';
import 'package:aviz/domain/models/user.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

enum AuthStatus { authenticated, unauthenticated, firstEntry }

class AuthRepo {
  final AuthRemoteDataSrc _authRemoteDataSrc;
  final AuthLocalDataSrc _authLocalDataSrc;

  AuthRepo({
    required AuthRemoteDataSrc authRemoteDataSrc,
    required AuthLocalDataSrc authLocalDataSrc,
  })  : _authLocalDataSrc = authLocalDataSrc,
        _authRemoteDataSrc = authRemoteDataSrc {
    _initUserStream();
  }

  final _userSubject = BehaviorSubject<User?>();
  Stream<User?> userStream() => _userSubject.stream;

  _initUserStream() async {
    final userId = _authLocalDataSrc.getToken();

    if (userId != null) {
      final fetchUserResult = await fetchUser(userId);
      fetchUserResult.when(
        ok: (user) {
          _userSubject.add(user);
        },
        error: (error) {
          Logger().w("Here Hoooray error: $error");

          _userSubject.addError(error.message);
        },
      );
    } else {
      _userSubject.add(null);
    }
  }

  // Methods
  Future<Result<User>> signup(
    String firstName,
    String lastName,
    String phoneNumber,
  ) async {
    try {
      final userResponseDto =
          await _authRemoteDataSrc.signup(firstName, lastName, phoneNumber);
      final user = UserMapper.fromDto(userResponseDto);

      await _authLocalDataSrc.saveToken(user.id.toString());

      return Result.ok(user);
    } on ApiException catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<bool>> verifyPhone(String phoneNumber, String code) async {
    try {
      final result = await _authRemoteDataSrc.verifyPhone(phoneNumber, code);

      final userId = _authLocalDataSrc.getToken()!;
      final userResponseDto = await _authRemoteDataSrc.fetchUser(userId);
      final user = UserMapper.fromDto(userResponseDto);

      _userSubject.add(user);

      return Result.ok(result);
    } on ApiException catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<String>> login(String phoneNumber) async {
    try {
      final loginResponseDto = await _authRemoteDataSrc.login(phoneNumber);
      String userId = loginResponseDto.token;

      await _authLocalDataSrc.saveToken(userId);
      return Result.ok(userId);
    } on ApiException catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<bool>> verifyLoginOtp(
    String phoneNumber,
    String code,
  ) async {
    try {
      final verified =
          await _authRemoteDataSrc.verifyLoginOtp(phoneNumber, code);

      final userId = _authLocalDataSrc.getToken()!;
      final userResponseDto = await _authRemoteDataSrc.fetchUser(userId);
      final user = UserMapper.fromDto(userResponseDto);

      _userSubject.add(user);

      return Result.ok(verified);
    } on ApiException catch (e) {
      await _authLocalDataSrc.removeToken();
      return Result.error(e);
    }
  }

  Future<Result<User>> fetchUser(String userId) async {
    try {
      final userResponseDto = await _authRemoteDataSrc.fetchUser(userId);
      final user = UserMapper.fromDto(userResponseDto);

      return Result.ok(user);
    } on ApiException catch (e) {
      // await _authLocalDataSrc.removeToken();
      Logger().w("I was called Hoooray :)");
      return Result.error(e);
    }
  }

  Future<Result<bool>> saveFirstEntryFlag() async {
    try {
      bool flagSaved = await _authLocalDataSrc.setFirstEntry(false);
      if (flagSaved) {
        return Result.ok(true);
      } else {
        return Result.ok(false);
      }
    } catch (e) {
      return Result.ok(false);
    }
  }

  bool isFirstEntry() {
    return _authLocalDataSrc.isFirstEntry();
  }

  // Close Streams
  void close() {
    if (!_userSubject.hasListener) {
      Logger().w("_userSubject Closed");
      _userSubject.close();
    }
  }
}
