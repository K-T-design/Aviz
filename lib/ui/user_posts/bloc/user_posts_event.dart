part of 'user_posts_bloc.dart';

sealed class UserPostsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class GetUserPostsEvent extends UserPostsEvent {}
