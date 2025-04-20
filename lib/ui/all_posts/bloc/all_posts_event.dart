part of 'all_posts_bloc.dart';

sealed class AllPostsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class GetAllPostsEvent extends AllPostsEvent {}
