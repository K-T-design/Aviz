import 'package:aviz/core/exceptions/api_exception.dart';
import 'package:aviz/core/exceptions/result.dart';
import 'package:aviz/data/data_src/local/auth_local_data_src.dart';
import 'package:aviz/data/data_src/remote/post_remote_data_src.dart';
import 'package:aviz/domain/models/page_data.dart';
import 'package:aviz/domain/models/pageable.dart';
import 'package:aviz/domain/models/post.dart';
import 'package:logger/logger.dart';

class PostRepo {
  final PostDataSrcRemote _postDataSrcRemote;
  final AuthLocalDataSrc _authLocalDataSrc;

  PostRepo({
    required PostDataSrcRemote postDataSrcRemote,
    required AuthLocalDataSrc authLocalDataSrc,
  })  : _postDataSrcRemote = postDataSrcRemote,
        _authLocalDataSrc = authLocalDataSrc;

  Future<Result<PageData<Post>>> fetchHottestPosts(Pageable pageable) async {
    try {
      final PageData pageDataDTO =
          await _postDataSrcRemote.fetchHottestPosts(pageable);

      final pageData = pageDataDTO.map((dto) => Post.fromJson(dto.toJson()));

      return Result.ok(pageData);
    } on ApiException catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<PageData<Post>>> fetchLatestPosts(Pageable pageable) async {
    try {
      final pageDataDTO = await _postDataSrcRemote.fetchLatestPosts(pageable);
      final pageData = pageDataDTO.map((dto) => Post.fromJson(dto.toJson()));

      return Result.ok(pageData);
    } on ApiException catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<PageData<Post>>> fetchUserPosts(Pageable pageable) async {
    try {
      final userId = _authLocalDataSrc.getToken();
      final pageDataDTO =
          await _postDataSrcRemote.fetchUserPosts(userId!, pageable);
      final pageData = pageDataDTO.map((dto) => Post.fromJson(dto.toJson()));

      return Result.ok(pageData);
    } on ApiException catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<List<Post>>> fetchAllPosts(Pageable pageable) async {
    try {
      final pageDataDTO = await _postDataSrcRemote.fetchAllPosts(pageable);
      final result =
          pageDataDTO.map((dto) => Post.fromJson(dto.toJson())).toList();

      return Result.ok(result);
    } on ApiException catch (e) {
      return Result.error(e);
    }
  }
}
