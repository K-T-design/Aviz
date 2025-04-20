part of 'otp_bloc.dart';

sealed class OtpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class VerifyOtpEvent extends OtpEvent {
  final String code;
  final String phoneNumber;
  final bool isSignup;

  VerifyOtpEvent({
    required this.code,
    required this.phoneNumber,
    required this.isSignup,
  });

  @override
  List<Object?> get props => [code, phoneNumber, isSignup];
}
