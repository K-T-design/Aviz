import 'package:aviz/data/repo/auth/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepo _authRepo;
  SignupBloc(this._authRepo) : super(SignupState.initial()) {
    on<SignupEvent>((event, emit) async {
      emit(state.copyWith(signupStatus: SignupLoading()));

      final names = event.name.split(" ");
      final firstName = names[0];
      final lastName = names[1];

      final signupResult = await _authRepo.signup(
        firstName,
        lastName,
        event.phoneNumber,
      );

      signupResult.when(
        ok: (data) => emit(state.copyWith(
          signupStatus: SignupSuccess(phoneNumber: event.phoneNumber),
        )),
        error: (error) => emit(state.copyWith(
          signupStatus: SignupError(message: error.message),
        )),
      );
    });
  }
}
