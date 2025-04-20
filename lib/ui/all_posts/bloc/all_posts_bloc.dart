import 'package:aviz/data/repo/post/post_repo.dart';
import 'package:aviz/domain/models/pageable.dart';
import 'package:aviz/domain/models/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'all_posts_event.dart';
part 'all_posts_state.dart';

class AllPostsBloc extends Bloc<AllPostsEvent, AllPostsState> {
  final PostRepo _postRepo;

  AllPostsBloc(this._postRepo) : super(AllPostsState.initial()) {
    on<GetAllPostsEvent>((event, emit) async {
      emit(state.copyWith(getAllPostsStatus: GetAllPostsLoading()));

      final pageable = Pageable(size: 10);
      final userPostsResult = await _postRepo.fetchAllPosts(pageable);

      userPostsResult.when(
        ok: (data) {
          emit(state.copyWith(
              getAllPostsStatus: GetAllPostsSuccess(
            allPosts: data,
          )));
        },
        error: (error) {
          emit(state.copyWith(
              getAllPostsStatus: GetAllPostsError(
            message: error.message,
          )));
        },
      );
    });
  }
}
