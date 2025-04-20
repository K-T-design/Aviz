import 'package:aviz/core/navigation/args/post_detail_page_args.dart';
import 'package:aviz/core/theme/app_sizes.dart';
import 'package:flutter/material.dart';

class DescTabView extends StatelessWidget {
  const DescTabView({
    super.key,
    required this.args,
  });

  final PostDetailPageArgs args;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.pageHorizontal,
          vertical: 16,
        ),
        child: Text(
          args.post.description ?? 'توضیحاتی وجود ندارد',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
