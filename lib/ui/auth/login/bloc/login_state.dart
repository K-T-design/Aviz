part of 'login_bloc.dart';

class LoginState extends Equatable {
  final LoginStatus loginStatus;

  const LoginState({required this.loginStatus});

  factory LoginState.initial() {
    return LoginState(loginStatus: LoginInitial());
  }

  LoginState copyWith({
    LoginStatus? loginStatus,
  }) {
    return LoginState(
      loginStatus: loginStatus ?? this.loginStatus,
    );
  }

  @override
  List<Object> get props => [loginStatus];
}

// Status
sealed class LoginStatus extends Equatable {
  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginStatus {}

final class LoginLoading extends LoginStatus {}

final class LoginSuccess extends LoginStatus {
  final String phoneNumber;

  LoginSuccess({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

final class LoginError extends LoginStatus {
  final String message;

  LoginError({required this.message});

  @override
  List<Object> get props => [message];
}
