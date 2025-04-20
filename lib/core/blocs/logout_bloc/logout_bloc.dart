import 'package:aviz/data/repo/auth/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthRepo _authRepo;

  LogoutBloc(this._authRepo) : super(LogoutInitial()) {
    on<LogoutEvent>((event, emit) async {
      final result = await _authRepo.logout();

      result.when(
        ok: (data) {
          data ? emit(LogoutSuccess()) : emit(LogoutError());
        },
        error: (error) {},
      );
    });
  }
}
