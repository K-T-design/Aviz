import 'package:aviz/core/exceptions/api_exception.dart';
import 'package:aviz/core/exceptions/result.dart';
import 'package:aviz/data/data_src/local/auth_local_data_src.dart';
import 'package:aviz/data/data_src/remote/post_remote_data_src.dart';
import 'package:aviz/domain/models/post.dart';
import 'package:rxdart/rxdart.dart';

class FavoritePostRepo {
  final PostDataSrcRemote _postDataSrcRemote;
  final AuthLocalDataSrc _authLocalDataSrc;

  FavoritePostRepo({
    required PostDataSrcRemote postDataSrcRemote,
    required AuthLocalDataSrc authLocalDataSrc,
  })  : _postDataSrcRemote = postDataSrcRemote,
        _authLocalDataSrc = authLocalDataSrc;

  final _favoritePostListSubject = BehaviorSubject<List<Post>>();
  Stream<List<Post>> favoritePostListStream() =>
      _favoritePostListSubject.stream;

  Future<Result<List<Post>>> fetchFavoritePosts() async {
    try {
      dynamic userId = _authLocalDataSrc.getToken();

      final favoritePostResponseDTO =
          await _postDataSrcRemote.fetchFavoritePosts(userId);

      final posts = favoritePostResponseDTO
          .map((dto) => Post.fromJson(dto.toJson()))
          .toList();

      _favoritePostListSubject.add(posts);

      return Result.ok(posts);
    } on ApiException catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<bool>> addPostToFavorite(int postId) async {
    try {
      dynamic userId = _authLocalDataSrc.getToken();
      userId = int.parse(userId);

      final isFavorite =
          await _postDataSrcRemote.addPostToFavorite(userId, postId);

      final current =
          _favoritePostListSubject.valueOrNull ?? []; // TODO: or null?

      late List<Post> updated;
      if (isFavorite) {
        final postResponseDTO =
            await _postDataSrcRemote.fetchPostById(postId: postId.toString());
        final newPost = Post.fromJson(postResponseDTO.toJson());
        updated = [newPost, ...current];
      } else {
        // remove post from favorites
        updated = current.where((post) => post.id != postId).toList();
        _favoritePostListSubject.add(updated);
        return Result.ok(false);
      }

      _favoritePostListSubject.add(updated);

      return Result.ok(isFavorite);
    } on ApiException catch (e) {
      return Result.error(e);
    }
  }

  void dispose() {
    _favoritePostListSubject.close();
  }
}
