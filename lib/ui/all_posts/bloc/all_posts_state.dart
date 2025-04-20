part of 'all_posts_bloc.dart';

class AllPostsState extends Equatable {
  final GetAllPostsStatus getAllPostsStatus;

  const AllPostsState({required this.getAllPostsStatus});

  factory AllPostsState.initial() {
    return AllPostsState(getAllPostsStatus: GetAllPostsInitial());
  }

  AllPostsState copyWith({
    GetAllPostsStatus? getAllPostsStatus,
  }) {
    return AllPostsState(
      getAllPostsStatus: getAllPostsStatus ?? this.getAllPostsStatus,
    );
  }

  @override
  List<Object> get props => [getAllPostsStatus];
}

// GetAllPostsEvent
sealed class GetAllPostsStatus extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetAllPostsInitial extends GetAllPostsStatus {}

final class GetAllPostsLoading extends GetAllPostsStatus {}

final class GetAllPostsSuccess extends GetAllPostsStatus {
  final List<Post> allPosts;

  GetAllPostsSuccess({required this.allPosts});

  @override
  List<Object> get props => [allPosts];
}

final class GetAllPostsError extends GetAllPostsStatus {
  final String message;

  GetAllPostsError({required this.message});

  @override
  List<Object> get props => [message];
}
