part of 'signup_bloc.dart';

class SignupState extends Equatable {
  final SignupStatus signupStatus;

  const SignupState({required this.signupStatus});

  factory SignupState.initial() {
    return SignupState(signupStatus: SignupInitial());
  }

  SignupState copyWith({
    SignupStatus? signupStatus,
  }) {
    return SignupState(
      signupStatus: signupStatus ?? this.signupStatus,
    );
  }

  @override
  List<Object> get props => [signupStatus];
}

// Status
sealed class SignupStatus extends Equatable {
  @override
  List<Object> get props => [];
}

final class SignupInitial extends SignupStatus {}

final class SignupLoading extends SignupStatus {}

final class SignupSuccess extends SignupStatus {
  final String phoneNumber;

  SignupSuccess({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

final class SignupError extends SignupStatus {
  final String message;

  SignupError({required this.message});

  @override
  List<Object> get props => [message];
}
