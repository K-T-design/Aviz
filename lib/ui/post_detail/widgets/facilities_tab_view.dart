import 'package:aviz/core/navigation/args/post_detail_page_args.dart';
import 'package:aviz/core/theme/app_sizes.dart';
import 'package:aviz/ui/post_detail/widgets/facility_item_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FacilitiesTabView extends StatelessWidget {
  const FacilitiesTabView({super.key, required this.args});

  final PostDetailPageArgs args;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 32),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSizes.pageHorizontal),
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/magicpen.svg'),
                const SizedBox(width: 8),
                const Text(
                  'امکانات',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(
              horizontal: AppSizes.pageHorizontal,
              vertical: 16,
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
            child: FacilityItemColumn(args: args),
          ),
        ],
      ),
    );
  }
}
