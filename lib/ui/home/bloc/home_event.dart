part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class GetHomeDataEvent extends HomeEvent {
  final bool refresh;

  GetHomeDataEvent({this.refresh = false});

  @override
  List<Object?> get props => [refresh];
}
