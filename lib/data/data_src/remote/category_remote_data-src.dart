import 'package:aviz/core/constants/endpoints.dart';
import 'package:aviz/core/exceptions/exception_handler.dart';
import 'package:aviz/data/dto/response/category_response_dto.dart';
import 'package:dio/dio.dart';

class CategoryRemoteDataSrc {
  final Dio _httpClient;
  final ExceptionHandler _exceptionHandler;

  CategoryRemoteDataSrc({
    required Dio httpClient,
    required ExceptionHandler exceptionHandler,
  })  : _httpClient = httpClient,
        _exceptionHandler = exceptionHandler;

  Future<List<CategoryResponseDto>> getCategories(int parentId) async {
    try {
      final response = await _httpClient.get(
        Endpoints.categories,
        queryParameters: {'parentId': parentId},
      );

      return (response.data as List)
          .map((json) => CategoryResponseDto.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _exceptionHandler(e, messages: {});
    }
  }
}
