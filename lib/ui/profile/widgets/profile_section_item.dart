import 'package:aviz/core/theme/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileSectionItem extends StatelessWidget {
  const ProfileSectionItem({
    super.key,
    required this.iconName,
    required this.text,
    required this.onTap,
  });

  final String iconName;
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.pageHorizontal,
          vertical: 10,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: AppSizes.pageHorizontal,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey,
            width: .3,
          ),
        ),
        child: Row(
          spacing: 16,
          children: [
            SvgPicture.asset('assets/icons/$iconName.svg'),
            Text(
              text,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            RotatedBox(
              quarterTurns: 2,
              child: SvgPicture.asset(
                'assets/icons/arrow-right.svg',
                colorFilter: const ColorFilter.mode(
                  Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
