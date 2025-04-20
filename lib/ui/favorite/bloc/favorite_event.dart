part of 'favorite_bloc.dart';

sealed class FavoriteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class WatchFavoritePosts extends FavoriteEvent {}

final class GetFavoritePostsEvent extends FavoriteEvent {}

final class ToggleFavoriteEvent extends FavoriteEvent {}
