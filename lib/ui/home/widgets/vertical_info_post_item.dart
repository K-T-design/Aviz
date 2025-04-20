import 'package:aviz/core/theme/app_colors.dart';
import 'package:aviz/core/utils/extensions/price_extension.dart';
import 'package:aviz/core/widgets/loading_in_button.dart';
import 'package:aviz/core/widgets/net_image.dart';
import 'package:aviz/domain/models/post.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class VerticalInfoPostItem extends StatelessWidget {
  const VerticalInfoPostItem({
    super.key,
    required this.post,
    required this.onTap,
  });

  final Post post;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: size.height * 0.2,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              blurStyle: BlurStyle.outer,
              offset: const Offset(0, -2),
              color: Colors.grey.withOpacity(0.2),
            ),
            BoxShadow(
              blurRadius: 1,
              blurStyle: BlurStyle.outer,
              offset: const Offset(0, 2),
              color: Colors.grey.withOpacity(0.2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 55,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title ?? '',
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    post.description ?? '',
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("قیمت:"),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: size.height * 0.005,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Skeleton.ignore(
                            child: Text(
                              post.price?.toPrice() ?? '000000000',
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 45,
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: NetImage(imageUrl: post.imageUrl)
                  // CachedNetworkImage(
                  //   imageUrl: post.imageUrl ?? '',
                  //   fit: BoxFit.cover,
                  //   placeholder: (context, url) => const LoadingInButton(
                  //     size: 14,
                  //     color: AppColors.primary,
                  //   ),
                  //   imageBuilder: (context, imageProvider) => Container(
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(8),
                  //       image: DecorationImage(
                  //         image: imageProvider,
                  //         fit: BoxFit.cover,
                  //       ),
                  //     ),
                  //   ),
                  //   errorWidget: (context, url, error) => const Skeleton.ignore(
                  //     child: Icon(Icons.error),
                  //   ),
                  // ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
