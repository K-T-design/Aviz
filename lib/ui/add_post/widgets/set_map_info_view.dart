import 'package:aviz/core/navigation/routes/app_routes.dart';
import 'package:aviz/core/theme/app_sizes.dart';
import 'package:aviz/core/widgets/main_button.dart';
import 'package:aviz/core/widgets/map_widget.dart';
import 'package:aviz/ui/add_post/bloc/add_post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SetMapInfoView extends StatelessWidget {
  const SetMapInfoView({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.pageHorizontal),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Row(
              spacing: 8,
              children: [
                SvgPicture.asset('assets/icons/map.svg'),
                const Text(
                  'موقعیت مکانی',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          const SliverToBoxAdapter(
            child: Text(
              'بعد انتخاب محل دقیق روی نقشه میتوانید نمایش آن را فعال یا غیر فعال کید تا حریم خصوصی شما خفظ شود.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
          SliverToBoxAdapter(
            child: MapWidget(
              onPressed: () async {
                final addPostBloc = context.read<AddPostBloc>();

                final result =
                    await Navigator.pushNamed(context, AppRoutes.map);
                final GeoPoint? geoPoint = result as GeoPoint?;

                if (geoPoint != null) {
                  addPostBloc.add(SetLatLongEvent(geoPoint: geoPoint));
                }
              },
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MainButton(
                  onPressed: () {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                  text: 'بعدی',
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
