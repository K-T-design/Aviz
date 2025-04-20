import 'dart:async';
import 'package:aviz/data/repo/auth/auth_repo.dart';
import 'package:aviz/domain/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;

  AuthBloc(this._authRepo) : super(AuthInitial()) {
    on<WatchUser>(_watchUser);
  }

  FutureOr<void> _watchUser(WatchUser event, Emitter<AuthState> emit) {
    return emit.onEach<User?>(
      _authRepo.userStream(),
      onData: (user) {
        if (user != null) {
          emit(Authenticated(user: user));
        } else {
          emit(Unauthenticated(isFirstEntry: _authRepo.isFirstEntry()));
        }
      },
      onError: (error, _) {
        emit(AuthError(message: error as String));
      },
    );
  }

  @override
  Future<void> close() {
    _authRepo.close();
    return super.close();
  }
}
