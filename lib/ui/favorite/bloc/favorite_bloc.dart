import 'package:aviz/data/repo/post/favorite_post_repo.dart';
import 'package:aviz/domain/models/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoritePostRepo _favoritePostRepo;

  FavoriteBloc(this._favoritePostRepo) : super(FavoriteState.initial()) {
    on<WatchFavoritePosts>((event, emit) async {
      return emit.onEach<List<Post>>(
        _favoritePostRepo.favoritePostListStream(),
        onData: (posts) {
          emit(state.copyWith(
              getFavoritePostsStatus:
                  GetFavoritePostsSuccess(favoritePosts: posts)));
        },
      );
    });
    on<GetFavoritePostsEvent>((event, emit) async {
      emit(state.copyWith(getFavoritePostsStatus: GetFavoritePostsLoading()));

      final postsResult = await _favoritePostRepo.fetchFavoritePosts();

      postsResult.when(
        ok: (posts) {
          emit(state.copyWith(
              getFavoritePostsStatus:
                  GetFavoritePostsSuccess(favoritePosts: posts)));
        },
        error: (error) {
          emit(state.copyWith(
              getFavoritePostsStatus:
                  GetFavoritePostsError(message: error.message)));
        },
      );
    });
  }
}
