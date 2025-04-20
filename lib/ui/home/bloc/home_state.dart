part of 'home_bloc.dart';

class HomeState extends Equatable {
  final GetHomeDataStatus getHomeDataStatus;

  const HomeState({required this.getHomeDataStatus});

  HomeState copyWith({
    GetHomeDataStatus? getHomeDataStatus,
  }) {
    return HomeState(
      getHomeDataStatus: getHomeDataStatus ?? this.getHomeDataStatus,
    );
  }

  factory HomeState.initial() {
    return HomeState(
      getHomeDataStatus: GetHomeDataInitial(),
    );
  }

  @override
  List<Object> get props => [getHomeDataStatus];
}

// GetHomeDataStatus
sealed class GetHomeDataStatus extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetHomeDataInitial extends GetHomeDataStatus {}

final class GetHomeDataLoading extends GetHomeDataStatus {}

final class GetHomeDataSuccess extends GetHomeDataStatus {
  final List<Post> hottestPosts;
  final List<Post> latestPosts;

  GetHomeDataSuccess({
    required this.hottestPosts,
    required this.latestPosts,
  });

  @override
  List<Object> get props => [hottestPosts, latestPosts];
}

final class GetHomeDataError extends GetHomeDataStatus {
  final String message;

  GetHomeDataError({required this.message});

  @override
  List<Object> get props => [message];
}
