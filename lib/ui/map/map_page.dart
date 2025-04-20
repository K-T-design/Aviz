import 'package:aviz/core/navigation/args/map_page_args.dart';
import 'package:aviz/core/theme/app_colors.dart';
import 'package:aviz/core/theme/app_sizes.dart';
import 'package:aviz/core/utils/hooks/use_page_args.dart';
import 'package:aviz/core/widgets/loading_in_button.dart';
import 'package:aviz/core/widgets/main_button.dart';
import 'package:aviz/ui/map/bloc/map_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapPage extends HookWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = usePageArgs<MapPageArgs?>();

    return BlocProvider(
      create: (context) => MapBloc(args?.initialLocation),
      child: const MapView(),
    );
  }
}

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    final isViewMode = context.read<MapBloc>().initialLocation != null;

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            return Stack(
              children: [
                OSMFlutter(
                  controller: context.read<MapBloc>().mapController,
                  onMapIsReady: (isReady) {
                    if (isReady) {
                      context.read<MapBloc>().add(MapReadyEvent());
                    }
                  },
                  mapIsLoading: const Center(
                    child: LoadingInButton(
                      color: AppColors.primary,
                    ),
                  ),
                  osmOption: OSMOption(
                    userTrackingOption: isViewMode
                        ? null
                        : const UserTrackingOption(
                            enableTracking: true,
                            unFollowUser: false,
                          ),
                    zoomOption: const ZoomOption(
                      initZoom: 18,
                      minZoomLevel: 3,
                      maxZoomLevel: 19,
                      stepZoom: 1.0,
                    ),
                    userLocationMarker: UserLocationMaker(
                      personMarker: const MarkerIcon(
                        icon: Icon(
                          Icons.add_location_alt_rounded,
                          color: Colors.red,
                          size: 50,
                        ),
                      ),
                      directionArrowMarker: const MarkerIcon(
                        icon: Icon(
                          Icons.add,
                          size: 50,
                        ),
                      ),
                    ),
                    // isPicker: true,
                  ),
                ),
                if (isViewMode)
                  Positioned(
                    bottom: AppSizes.pageEndSpace,
                    right: AppSizes.pageHorizontal,
                    child: FloatingActionButton.extended(
                      onPressed: () => Navigator.pop(context),
                      label: const Text('بازگشت'),
                    ),
                  ),
                if (!state.mapIsLoading)
                  Visibility(
                    visible: state.pinnedLocation == null && !isViewMode,
                    child: const Center(
                      child: Icon(
                        Icons.location_pin,
                        size: 50,
                        color: Colors.red,
                      ),
                    ),
                  ),
                Positioned(
                  right: AppSizes.pageHorizontal,
                  bottom: AppSizes.pageEndSpace,
                  left: AppSizes.pageHorizontal,
                  child: Visibility(
                    visible: !state.mapIsLoading && !isViewMode,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 16,
                      children: [
                        FloatingActionButton(
                          child: state.pinnedLocation == null
                              ? const Icon(Icons.location_on)
                              : const Icon(Icons.close),
                          onPressed: () {
                            if (state.pinnedLocation == null) {
                              context
                                  .read<MapBloc>()
                                  .add(ReturnToCurrentLocationEvent());
                            } else {
                              context.read<MapBloc>().add(ClearPinEvent());
                            }
                          },
                        ),
                        Expanded(
                          child: MainButton(
                            text: state.pinnedLocation == null
                                ? 'انتخاب موقعیت مکانی'
                                : 'تایید',
                            onPressed: () async {
                              if (state.pinnedLocation == null) {
                                context.read<MapBloc>().add(PinLocationEvent());
                              } else {
                                Navigator.pop(context, state.pinnedLocation);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
