part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}

final class Authenticated extends AuthState {
  final User user;

  Authenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

final class Unauthenticated extends AuthState {
  final bool isFirstEntry;

  Unauthenticated({required this.isFirstEntry});

  @override
  List<Object?> get props => [isFirstEntry];
}

final class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}
