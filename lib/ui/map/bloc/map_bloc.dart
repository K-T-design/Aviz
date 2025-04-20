import 'package:aviz/ui/map/widgets/build_marker_icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final MapController mapController;
  final GeoPoint? initialLocation;

  MapBloc(this.initialLocation)
      : mapController = initialLocation == null
            ? MapController.withUserPosition(
                areaLimit: const BoundingBox.world(),
              )
            : MapController.withPosition(
                initPosition: initialLocation,
                areaLimit: const BoundingBox.world(),
              ),
        super(MapState.initial()) {
    on<MapReadyEvent>((event, emit) async {
      if (initialLocation != null) {
        await mapController.addMarker(
          initialLocation!,
          markerIcon: buildMarkerIcon(),
        );
        emit(state.copyWith(
          mapIsLoading: false,
          pinnedLocation: initialLocation,
        ));
      } else {
        emit(state.copyWith(mapIsLoading: false));
      }
    });

    on<ReturnToCurrentLocationEvent>((event, emit) async {
      try {
        await mapController.currentLocation();
      } catch (e) {
        emit(state.copyWith(error: 'امکان دسترسی به موقعیت فعلی وجود ندارد'));
      }
    });

    on<PinLocationEvent>((event, emit) async {
      try {
        final List<GeoPoint> existing = await mapController.geopoints;

        // remove previous markers
        for (final pt in existing) {
          await mapController.removeMarker(pt);
        }

        final center = await mapController.centerMap;

        await mapController.addMarker(
          center,
          markerIcon: buildMarkerIcon(),
        );

        emit(state.copyWith(pinnedLocation: center));
      } catch (e) {
        emit(state.copyWith(error: 'مشکلی پیش آمده، دوباره امتحان کنید'));
      }
    });

    on<ClearPinEvent>((event, emit) async {
      final List<GeoPoint> existing = await mapController.geopoints;

      // remove previous markers
      for (final pt in existing) {
        await mapController.removeMarker(pt);
      }

      emit(state.copyWith(pinnedLocation: null));
    });
  }

  @override
  Future<void> close() {
    mapController.dispose();
    return super.close();
  }
}
