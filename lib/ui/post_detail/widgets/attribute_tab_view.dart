import 'package:aviz/core/navigation/args/map_page_args.dart';
import 'package:aviz/core/navigation/args/post_detail_page_args.dart';
import 'package:aviz/core/navigation/routes/app_routes.dart';
import 'package:aviz/core/theme/app_sizes.dart';
import 'package:aviz/core/widgets/map_widget.dart';
import 'package:aviz/ui/post_detail/widgets/post_attribute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AttributeTabView extends StatelessWidget {
  const AttributeTabView({
    super.key,
    required this.args,
  });

  final PostDetailPageArgs args;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 24),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: AppSizes.pageHorizontal,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.pageHorizontal,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey,
                width: .3,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PostAttribute(
                  title: 'متراژ',
                  value: args.post.area != null
                      ? args.post.area.toString()
                      : 'نامشخص',
                ),
                PostAttribute(
                  title: 'اتاق',
                  value: args.post.numOfRooms != null
                      ? args.post.numOfRooms!.toInt().toString()
                      : 'نامشخص',
                ),
                PostAttribute(
                  title: 'طبقه',
                  value: args.post.floor != null
                      ? args.post.floor.toString()
                      : 'نامشخص',
                ),
                PostAttribute(
                  title: 'ساخت',
                  value: args.post.builtYear != null
                      ? args.post.builtYear.toString()
                      : 'نامشخص',
                ),
              ],
            ),
          ),
          const SizedBox(height: 36),
          if (args.post.latitude != null && args.post.longitude != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.pageHorizontal),
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/map.svg'),
                  const SizedBox(width: 8),
                  const Text(
                    'موقعیت مکانی',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.pageHorizontal),
              child: MapWidget(
                onPressed: () {
                  late GeoPoint? geoPoint;
                  if (args.post.latitude != null &&
                      args.post.longitude != null) {
                    geoPoint = GeoPoint(
                      latitude: args.post.latitude!,
                      longitude: args.post.longitude!,
                    );
                  }

                  Navigator.pushNamed(
                    context,
                    AppRoutes.map,
                    arguments: MapPageArgs(initialLocation: geoPoint),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
