import 'package:aviz/core/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({
    super.key,
    this.buttonText,
    this.onPressed,
  });

  final String? buttonText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return AspectRatio(
      aspectRatio: 343 / 144,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/map.png'),
              ),
            ),
          ),
          Center(
            child: MainButton(
              text: buttonText ?? 'موقعیت مکانی',
              width: size.width * 0.45,
              icon: SvgPicture.asset('assets/icons/location.svg'),
              onPressed: onPressed,
            ),
          ),
        ],
      ),
    );
  }
}
