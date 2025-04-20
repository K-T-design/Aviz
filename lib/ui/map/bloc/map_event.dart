part of 'map_bloc.dart';

sealed class MapEvent extends Equatable {
  const MapEvent();
  @override
  List<Object?> get props => [];
}

final class InitMapControllerEvent extends MapEvent {}

final class MapReadyEvent extends MapEvent {}

final class ReturnToCurrentLocationEvent extends MapEvent {}

final class PinLocationEvent extends MapEvent {}

final class ClearPinEvent extends MapEvent {}
