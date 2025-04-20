part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  final String phoneNumber;

  const LoginEvent({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}
