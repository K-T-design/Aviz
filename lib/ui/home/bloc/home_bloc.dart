import 'package:aviz/data/repo/post/post_repo.dart';
import 'package:aviz/domain/models/pageable.dart';
import 'package:aviz/domain/models/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PostRepo _postRepo;

  HomeBloc(this._postRepo) : super(HomeState.initial()) {
    on<GetHomeDataEvent>((event, emit) async {
      if (!event.refresh) {
        emit(state.copyWith(getHomeDataStatus: GetHomeDataLoading()));
      }

      final hottestPageable = Pageable();
      final hottestResult = await _postRepo.fetchHottestPosts(hottestPageable);

      final latestPageable = Pageable(size: 5);
      final latestResult = await _postRepo.fetchLatestPosts(latestPageable);

      hottestResult.when(
        ok: (hottestPageData) {
          latestResult.when(
            ok: (latestPageData) {
              emit(state.copyWith(
                getHomeDataStatus: GetHomeDataSuccess(
                  hottestPosts: hottestPageData.content,
                  latestPosts: latestPageData.content,
                ),
              ));
            },
            error: (error) {
              emit(state.copyWith(
                  getHomeDataStatus: GetHomeDataError(message: error.message)));
            },
          );
        },
        error: (error) {
          emit(state.copyWith(
              getHomeDataStatus: GetHomeDataError(message: error.message)));
        },
      );
    });
  }
}
