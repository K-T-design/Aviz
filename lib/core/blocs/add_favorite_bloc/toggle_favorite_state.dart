part of 'toggle_favorite_bloc.dart';

class ToggleFavoriteState extends Equatable {
  final ToggleFavoriteStatus toggleFavoriteStatus;

  const ToggleFavoriteState({required this.toggleFavoriteStatus});

  factory ToggleFavoriteState.initial() {
    return ToggleFavoriteState(toggleFavoriteStatus: ToggleFavoriteInitial());
  }

  ToggleFavoriteState copyWith({
    ToggleFavoriteStatus? toggleFavoriteStatus,
  }) {
    return ToggleFavoriteState(
      toggleFavoriteStatus: toggleFavoriteStatus ?? this.toggleFavoriteStatus,
    );
  }

  @override
  List<Object?> get props => [toggleFavoriteStatus];
}

sealed class ToggleFavoriteStatus extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ToggleFavoriteInitial extends ToggleFavoriteStatus {}

final class ToggleFavoriteLoading extends ToggleFavoriteStatus {}

final class ToggleFavoriteSuccess extends ToggleFavoriteStatus {
  final bool isFavorite;

  ToggleFavoriteSuccess({required this.isFavorite});

  @override
  List<Object?> get props => [isFavorite];
}

final class ToggleFavoriteError extends ToggleFavoriteStatus {}
