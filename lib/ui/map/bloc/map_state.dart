part of 'map_bloc.dart';

class MapState extends Equatable {
  static const _noChange = Object();

  final bool mapIsLoading;
  final GeoPoint? pinnedLocation;
  final String? error;

  factory MapState.initial() => const MapState(mapIsLoading: true);

  const MapState({
    required this.mapIsLoading,
    this.pinnedLocation,
    this.error,
  });

  MapState copyWith({
    bool? mapIsLoading,
    Object? pinnedLocation = _noChange,
    Object? error = _noChange,
  }) {
    return MapState(
      mapIsLoading: mapIsLoading ?? this.mapIsLoading,
      pinnedLocation: identical(pinnedLocation, _noChange)
          ? this.pinnedLocation
          : pinnedLocation as GeoPoint?,
      error: identical(error, _noChange) ? this.error : error as String?,
    );
  }

  @override
  List<Object?> get props => [mapIsLoading, pinnedLocation, error];
}
