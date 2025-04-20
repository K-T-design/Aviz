part of 'otp_bloc.dart';

class OtpState extends Equatable {
  final VerifyOtpStatus verifyOtpStatus;

  const OtpState({required this.verifyOtpStatus});

  factory OtpState.initial() {
    return OtpState(verifyOtpStatus: VerifyOtpInitial());
  }

  OtpState copyWith({VerifyOtpStatus? verifyOtpStatus}) {
    return OtpState(
      verifyOtpStatus: verifyOtpStatus ?? this.verifyOtpStatus,
    );
  }

  @override
  List<Object> get props => [verifyOtpStatus];
}

// Status
class VerifyOtpStatus extends Equatable {
  @override
  List<Object> get props => [];
}

class VerifyOtpInitial extends VerifyOtpStatus {}

class VerifyOtpLoading extends VerifyOtpStatus {}

class VerifyOtpSuccess extends VerifyOtpStatus {}

class VerifyOtpError extends VerifyOtpStatus {
  final String message;

  VerifyOtpError({required this.message});

  @override
  List<Object> get props => [message];
}
