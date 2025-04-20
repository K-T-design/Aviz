import 'package:aviz/data/repo/auth/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepo _authRepo;

  LoginBloc(this._authRepo) : super(LoginState.initial()) {
    on<LoginEvent>(
      (event, emit) async {
        emit(state.copyWith(loginStatus: LoginLoading()));

        final loginResult = await _authRepo.login(event.phoneNumber);

        loginResult.when(
          ok: (data) => emit(state.copyWith(
              loginStatus: LoginSuccess(phoneNumber: event.phoneNumber))),
          error: (error) {
            emit(
              state.copyWith(
                loginStatus: LoginError(
                  message: error.message,
                ),
              ),
            );
          },
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
