part of 'user_posts_bloc.dart';

class UserPostsState extends Equatable {
  final GetUserPostsStatus getUserPostsStatus;

  const UserPostsState({required this.getUserPostsStatus});

  factory UserPostsState.initial() {
    return UserPostsState(getUserPostsStatus: GetUserPostsInitial());
  }

  UserPostsState copyWith({
    GetUserPostsStatus? getUserPostsStatus,
  }) {
    return UserPostsState(
      getUserPostsStatus: getUserPostsStatus ?? this.getUserPostsStatus,
    );
  }

  @override
  List<Object?> get props => [getUserPostsStatus];
}

// GetUserPostsEvent
sealed class GetUserPostsStatus extends Equatable {
  @override
  List<Object?> get props => [];
}

final class GetUserPostsInitial extends GetUserPostsStatus {}

final class GetUserPostsLoading extends GetUserPostsStatus {}

final class GetUserPostsSuccess extends GetUserPostsStatus {
  final List<Post> userPosts;

  GetUserPostsSuccess({required this.userPosts});

  @override
  List<Object?> get props => [userPosts];
}

final class GetUserPostsError extends GetUserPostsStatus {
  final String message;

  GetUserPostsError({required this.message});
}
