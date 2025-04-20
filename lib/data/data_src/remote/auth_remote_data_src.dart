import 'package:aviz/core/constants/endpoints.dart';
import 'package:aviz/core/exceptions/exception_handler.dart';
import 'package:aviz/core/utils/extensions/retry_option_extension.dart';
import 'package:aviz/data/dto/response/login_response_dto.dart';
import 'package:aviz/data/dto/response/user_response_dto.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class AuthRemoteDataSrc {
  final Dio _httpClient;
  final ExceptionHandler _exceptionHandler;

  AuthRemoteDataSrc({
    required Logger logger,
    required Dio httpClient,
    required ExceptionHandler handleException,
  })  : _httpClient = httpClient,
        _exceptionHandler = handleException;

  Future<UserResponseDto> signup(
    String firstName,
    String lastName,
    String phoneNumber,
  ) async {
    try {
      // TODO: param(RequestModel) instead of Map for 'data'
      final response = await _httpClient.post(
        Endpoints.signup,
        data: {
          'firstName': firstName,
          'lastName': lastName,
          'phoneNumber': phoneNumber
        },
      );

      return UserResponseDto.fromJson(response.data);
    } on DioException catch (e) {
      throw _exceptionHandler(e, messages: {
        'PHONE_ALREADY_EXISTS': 'این شماره موبایل قبلا ثبت شده است',
      });
    }
  }

  Future<bool> verifyPhone(String phoneNumber, String code) async {
    try {
      await _httpClient.put(
        Endpoints.verifyPhone,
        queryParameters: {'verificationCode': code, 'phoneNumber': phoneNumber},
      );

      return true;
    } on DioException catch (e) {
      throw _exceptionHandler(e, messages: {});
    }
  }

  Future<LoginResponseDto> login(String phoneNumber) async {
    try {
      final response = await _httpClient.post(
        Endpoints.login,
        queryParameters: {'phoneNumber': phoneNumber},
      );

      return LoginResponseDto.fromJson(response.data);
    } on DioException catch (e) {
      throw _exceptionHandler(e, messages: {
        'PHONE_NOT_CONFIRMED': 'این شماره موبایل تایید نشده است',
        'PHONE_NOT_EXISTS': 'کاربری با این شماره ثبت نام نکرده است',
      });
    }

    // on DioException catch (e) {
    //   throw _exceptionHandler(
    //     e,
    //     // messages: const ErrorMessages({
    //     //   ErrorCode.phoneNumExists: 'کاربری با این شماره ثبت نام نکرده است',
    //     //   ErrorCode.phoneNumNotConfirmed: 'این شماره موبایل تایید نشده است',
    //     // }),
    //     messages: const ErrorMessages(
    //       forbidden: 'این شماره موبایل تایید نشده است',
    //       notFound: 'کاربری با این شماره ثبت نام نکرده است',
    //     ),
    //   );
    // } catch (e) {
    //   throw UnknownException();
    // }
  }

  Future<bool> verifyLoginOtp(String phoneNumber, String code) async {
    try {
      await _httpClient.put(
        Endpoints.verifyOtp,
        queryParameters: {
          'verificationCode': code,
          'phoneNumber': phoneNumber,
        },
      );

      return true;
    } on DioException catch (e) {
      throw _exceptionHandler(e, messages: {
        'VERIFICATION_CODE_EXPIRED': 'کد منقضی شده است',
        'VERIFICATION_CODE_NOT_CORRECT': 'کد وارد شده صحیح نمی باشد',
      });
    }
  }

  Future<UserResponseDto> fetchUser(String userId) async {
    try {
      final response = await _httpClient.get(
        Endpoints.user,
        queryParameters: {
          'id': userId,
        },
        options: Options().enableRetry(),
      );

      return UserResponseDto.fromJson(response.data);
    } on DioException catch (e) {
      throw _exceptionHandler(e, messages: {});
    }
  }
}
