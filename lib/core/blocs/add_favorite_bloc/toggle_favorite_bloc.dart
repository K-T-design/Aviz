import 'package:aviz/data/repo/post/favorite_post_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'toggle_favorite_event.dart';
part 'toggle_favorite_state.dart';

class ToggleFavoriteBloc
    extends Bloc<ToggleFavoriteEvent, ToggleFavoriteState> {
  final FavoritePostRepo _favoritePostRepo;

  ToggleFavoriteBloc(this._favoritePostRepo)
      : super(ToggleFavoriteState.initial()) {
    on<TogglePostFavoriteEvent>((event, emit) async {
      final addToFavoriteResult =
          await _favoritePostRepo.addPostToFavorite(event.postId);

      addToFavoriteResult.when(
        ok: (isFavorite) {
          emit(state.copyWith(
              toggleFavoriteStatus:
                  ToggleFavoriteSuccess(isFavorite: isFavorite)));
        },
        error: (error) {
          emit(state.copyWith(toggleFavoriteStatus: ToggleFavoriteError()));
        },
      );
    });

    on<SetInitialFavoriteEvent>((event, emit) async {
      emit(state.copyWith(toggleFavoriteStatus: ToggleFavoriteInitial()));
    });
  }
}
