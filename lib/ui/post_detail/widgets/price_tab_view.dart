import 'package:aviz/core/navigation/args/post_detail_page_args.dart';
import 'package:aviz/core/theme/app_sizes.dart';
import 'package:aviz/core/utils/extensions/price_extension.dart';
import 'package:flutter/material.dart';

class PriceTabView extends StatelessWidget {
  const PriceTabView({
    super.key,
    required this.args,
  });

  final PostDetailPageArgs args;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
        child: Column(
          spacing: 16,
          children: [
            Visibility(
              visible: (args.post.price == null || args.post.area == null)
                  ? false
                  : true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'قیمت هر متر:',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text((args.post.price! / (args.post.area!)).toPrice()),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: .3,
              height: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'قیمت کل:',
                  style: TextStyle(fontSize: 15),
                ),
                Text(args.post.price?.toPrice() ?? ''),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
