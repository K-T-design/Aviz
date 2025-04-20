import 'package:aviz/core/theme/app_colors.dart';
import 'package:aviz/core/widgets/loading_in_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NetImage extends StatelessWidget {
  const NetImage({
    super.key,
    required this.imageUrl,
    this.radius = 8,
  });

  final String? imageUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final bool hasValidUrl = imageUrl != null && imageUrl!.isNotEmpty;

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: hasValidUrl
          ? CachedNetworkImage(
              imageUrl: imageUrl!,
              fit: BoxFit.cover,
              placeholder: (context, url) => const LoadingInButton(
                size: 14,
                color: AppColors.primary,
              ),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Skeleton.ignore(
                child: Icon(Icons.error),
              ),
            )
          : Image.asset(
              'assets/images/no_image.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
    );
  }
}
