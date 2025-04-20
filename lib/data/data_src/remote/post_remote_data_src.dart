import 'package:aviz/core/constants/endpoints.dart';
import 'package:aviz/core/exceptions/exception_handler.dart';
import 'package:aviz/data/dto/response/post_response_dto.dart';
import 'package:aviz/domain/models/page_data.dart';
import 'package:aviz/domain/models/pageable.dart';
import 'package:aviz/domain/models/post.dart';
import 'package:dio/dio.dart';

class PostDataSrcRemote {
  final Dio _httpClient;
  final ExceptionHandler _exceptionHandler;

  PostDataSrcRemote({
    required Dio httpClient,
    required ExceptionHandler exceptionHandler,
  })  : _httpClient = httpClient,
        _exceptionHandler = exceptionHandler;

  Future<PageData<PostResponseDTO>> fetchHottestPosts(Pageable pageable) async {
    try {
      final response = await _httpClient.get(
        Endpoints.hottest,
        queryParameters: pageable.toJson(),
      );

      return PageData<PostResponseDTO>.fromJson(
        response.data,
        (json) => PostResponseDTO.fromJson(json),
      );
    } on DioException catch (e) {
      throw _exceptionHandler(e, messages: {});
    }
  }

  Future<PageData<PostResponseDTO>> fetchLatestPosts(Pageable pageable) async {
    try {
      final response = await _httpClient.get(
        Endpoints.latest,
        queryParameters: pageable.toJson(),
      );

      return PageData<PostResponseDTO>.fromJson(
        response.data,
        (json) => PostResponseDTO.fromJson(json),
      );
    } on DioException catch (e) {
      throw _exceptionHandler(e, messages: {});
    }
  }

  Future<PostResponseDTO> addPost({
    required Post post,
    required int userId,
    required int categoryId,
  }) async {
    try {
      final response = await _httpClient.post(
        Endpoints.addPost,
        queryParameters: {
          'userId': userId,
          'categoryId': categoryId,
        },
        data: post.toJson(),
      );

      return PostResponseDTO.fromJson(response.data);
    } on DioException catch (e) {
      throw _exceptionHandler(e, messages: {
        // 'USER_NOT_FOUND': '',
        // 'CATEGORY_NOT_FOUND': '',
      });
    }
  }

  Future<PageData<PostResponseDTO>> fetchUserPosts(
      String userId, Pageable pageable) async {
    try {
      final response = await _httpClient.get(
        Endpoints.userPosts,
        queryParameters: {
          'userId': userId,
          ...pageable.toJson(),
        },
      );

      return PageData<PostResponseDTO>.fromJson(
        response.data,
        (json) => PostResponseDTO.fromJson(json),
      );
    } on DioException catch (e) {
      throw _exceptionHandler(e, messages: {});
    }
  }

  Future<List<PostResponseDTO>> fetchAllPosts(Pageable pageable) async {
    try {
      final response = await _httpClient.get(
        Endpoints.allPosts,
        // queryParameters: pageable.toJson(),
      );

      return (response.data as List)
          .map(
            (e) => PostResponseDTO.fromJson(e),
          )
          .toList();

      // return PageData<PostResponseDTO>.fromJson(
      //   response.data,
      //   (json) => PostResponseDTO.fromJson(json),
      // );
    } on DioException catch (e) {
      throw _exceptionHandler(e, messages: {});
    }
  }

  Future<List<PostResponseDTO>> fetchFavoritePosts(String userId) async {
    try {
      final response = await _httpClient.get(
        Endpoints.favoritePosts,
        queryParameters: {'userId': userId},
      );

      return (response.data as List)
          .map((e) => PostResponseDTO.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw _exceptionHandler(e, messages: {});
    }
  }

  Future<bool> addPostToFavorite(int userId, int postId) async {
    try {
      final response = await _httpClient.put(
        Endpoints.addPostToFavorite,
        queryParameters: {
          'userId': userId,
          'postId': postId,
        },
      );

      return response.data['isFavorite'];
    } on DioException catch (e) {
      throw _exceptionHandler(e, messages: {});
    }
  }

  Future<PostResponseDTO> fetchPostById({required String postId}) async {
    try {
      final path = Endpoints.postById.replaceFirst('{postId}', postId);
      final response = await _httpClient.get(path);

      return PostResponseDTO.fromJson(response.data);
    } on DioException catch (e) {
      throw _exceptionHandler(e, messages: {
        // 'USER_NOT_FOUND': '',
        // 'CATEGORY_NOT_FOUND': '',
      });
    }
  }
}
