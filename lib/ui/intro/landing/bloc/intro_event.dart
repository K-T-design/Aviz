part of 'intro_bloc.dart';

sealed class IntroEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class IntroPageSeen extends IntroEvent {}
