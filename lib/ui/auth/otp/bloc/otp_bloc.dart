import 'package:aviz/core/exceptions/result.dart';
import 'package:aviz/data/repo/auth/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final AuthRepo _authRepo;

  OtpBloc(this._authRepo) : super(OtpState.initial()) {
    on<VerifyOtpEvent>(
      (event, emit) async {
        emit(state.copyWith(verifyOtpStatus: VerifyOtpLoading()));

        late final Result<bool> verifyResult;
        if (event.isSignup) {
          verifyResult = await _authRepo.verifyPhone(
            event.phoneNumber,
            event.code,
          );
        } else {
          verifyResult = await _authRepo.verifyLoginOtp(
            event.phoneNumber,
            event.code,
          );
        }

        verifyResult.when(
          ok: (data) =>
              emit(state.copyWith(verifyOtpStatus: VerifyOtpSuccess())),
          error: (error) => emit(
            state.copyWith(
              verifyOtpStatus: VerifyOtpError(message: error.message),
            ),
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _authRepo.close();
    return super.close();
  }
}
