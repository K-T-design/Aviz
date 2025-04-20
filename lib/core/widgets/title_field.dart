import 'package:aviz/core/theme/app_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TitleField extends StatelessWidget {
  const TitleField({
    super.key,
    required this.text,
    required this.iconSvgPath,
    this.enablePadding = false,
  });

  final String text;
  final String iconSvgPath;
  final bool enablePadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: enablePadding
          ? const EdgeInsets.symmetric(horizontal: AppSizes.pageHorizontal)
          : EdgeInsets.zero,
      child: Row(
        spacing: 8,
        children: [
          SvgPicture.asset(iconSvgPath),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
