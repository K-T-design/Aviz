part of 'favorite_bloc.dart';

class FavoriteState extends Equatable {
  final GetFavoritePostsStatus getFavoritePostsStatus;

  const FavoriteState({required this.getFavoritePostsStatus});

  factory FavoriteState.initial() {
    return FavoriteState(getFavoritePostsStatus: GetFavoritePostsInitial());
  }

  FavoriteState copyWith({
    GetFavoritePostsStatus? getFavoritePostsStatus,
  }) {
    return FavoriteState(
      getFavoritePostsStatus:
          getFavoritePostsStatus ?? this.getFavoritePostsStatus,
    );
  }

  @override
  List<Object> get props => [getFavoritePostsStatus];
}

// GetFavoritePostsEvent
sealed class GetFavoritePostsStatus extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetFavoritePostsInitial extends GetFavoritePostsStatus {}

final class GetFavoritePostsLoading extends GetFavoritePostsStatus {}

final class GetFavoritePostsSuccess extends GetFavoritePostsStatus {
  final List<Post> favoritePosts;

  GetFavoritePostsSuccess({required this.favoritePosts});

  @override
  List<Object> get props => [favoritePosts];
}

final class GetFavoritePostsError extends GetFavoritePostsStatus {
  final String message;

  GetFavoritePostsError({required this.message});

  @override
  List<Object> get props => [message];
}
