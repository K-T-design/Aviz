import 'package:aviz/core/exceptions/api_exception.dart';
import 'package:aviz/core/exceptions/result.dart';
import 'package:aviz/data/data_src/local/auth_local_data_src.dart';
import 'package:aviz/data/data_src/remote/category_remote_data-src.dart';
import 'package:aviz/data/data_src/remote/post_remote_data_src.dart';
import 'package:aviz/data/dto/response/category_response_dto.dart';
import 'package:aviz/data/dto/response/post_response_dto.dart';
import 'package:aviz/domain/mappers/category_mapper.dart';
import 'package:aviz/domain/mappers/post_mapper.dart';
import 'package:aviz/domain/models/category.dart';
import 'package:aviz/domain/models/post.dart';

class AddPostRepo {
  final PostDataSrcRemote _postDataSrcRemote;
  final AuthLocalDataSrc _authLocalDataSrc;
  final CategoryRemoteDataSrc _categoryRemoteDataSrc;

  AddPostRepo({
    required PostDataSrcRemote postDataSrcRemote,
    required AuthLocalDataSrc authLocalDataSrc,
    required CategoryRemoteDataSrc categoryRemoteDataSrc,
  })  : _postDataSrcRemote = postDataSrcRemote,
        _authLocalDataSrc = authLocalDataSrc,
        _categoryRemoteDataSrc = categoryRemoteDataSrc;

  Future<Result<List<Category>>> getCategories(int parentId) async {
    try {
      final List<CategoryResponseDto> categoryResponseDtoList =
          await _categoryRemoteDataSrc.getCategories(parentId);

      final categoryList = categoryResponseDtoList
          .map((e) => CategoryMapper.fromDto(e))
          .toList();

      return Result.ok(categoryList);
    } on ApiException catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<Post>> addPost(Post post, int categoryId) async {
    try {
      dynamic userId = _authLocalDataSrc.getToken();
      userId = int.parse(userId!);

      final PostResponseDTO postResponseDTO = await _postDataSrcRemote.addPost(
        post: post,
        userId: userId,
        categoryId: categoryId,
      );
      final postResponse = PostMapper.fromDto(postResponseDTO);

      return Result.ok(postResponse);
    } on ApiException catch (e) {
      return Result.error(e);
    }
  }
}
