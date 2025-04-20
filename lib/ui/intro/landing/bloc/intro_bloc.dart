import 'package:aviz/data/repo/auth/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'intro_event.dart';
part 'intro_state.dart';

class IntroBloc extends Bloc<IntroEvent, IntroState> {
  final AuthRepo _authRepo;

  IntroBloc(this._authRepo) : super(IntroState()) {
    on<IntroPageSeen>((event, emit) async {
      await _authRepo.saveFirstEntryFlag();
    });
  }
}
