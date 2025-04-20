import 'package:aviz/data/repo/post/post_repo.dart';
import 'package:aviz/domain/models/pageable.dart';
import 'package:aviz/domain/models/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_posts_event.dart';
part 'user_posts_state.dart';

class UserPostsBloc extends Bloc<UserPostsEvent, UserPostsState> {
  final PostRepo _postRepo;

  UserPostsBloc(this._postRepo) : super(UserPostsState.initial()) {
    on<GetUserPostsEvent>((event, emit) async {
      emit(state.copyWith(getUserPostsStatus: GetUserPostsLoading()));

      final pageable = Pageable(size: 10);
      final userPostsResult = await _postRepo.fetchUserPosts(pageable);

      userPostsResult.when(
        ok: (data) {
          emit(state.copyWith(
              getUserPostsStatus: GetUserPostsSuccess(
            userPosts: data.content,
          )));
        },
        error: (error) {
          emit(state.copyWith(
              getUserPostsStatus: GetUserPostsError(
            message: error.message,
          )));
        },
      );
    });
  }
}
