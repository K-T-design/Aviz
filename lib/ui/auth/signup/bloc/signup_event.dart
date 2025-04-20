part of 'signup_bloc.dart';

class SignupEvent extends Equatable {
  final String name;
  final String phoneNumber;

  const SignupEvent({
    required this.name,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [name, phoneNumber];
}
