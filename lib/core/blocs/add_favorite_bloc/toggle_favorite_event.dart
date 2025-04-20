part of 'toggle_favorite_bloc.dart';

sealed class ToggleFavoriteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TogglePostFavoriteEvent extends ToggleFavoriteEvent {
  final int postId;

  TogglePostFavoriteEvent({required this.postId});

  @override
  List<Object?> get props => [postId];
}

class SetInitialFavoriteEvent extends ToggleFavoriteEvent {}
