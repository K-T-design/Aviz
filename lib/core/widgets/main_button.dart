import 'package:aviz/core/theme/app_colors.dart';
import 'package:aviz/core/widgets/loading_in_button.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    this.text,
    this.textSize = 16,
    required this.onPressed,
    this.child,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
  });

  final String? text;
  final double textSize;
  final Widget? icon;
  final Widget? child;
  final bool isLoading;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return SizedBox(
      height: height ?? size.height * 0.06,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: WidgetStateProperty.all(padding),
          backgroundColor:
              WidgetStateProperty.all(backgroundColor ?? AppColors.primary),
          foregroundColor:
              WidgetStateProperty.all(foregroundColor ?? Colors.white),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: AppColors.primary),
            ),
          ),
        ),
        child: isLoading
            ? const LoadingInButton()
            : child ??
                (text != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            text!,
                            style: TextStyle(fontSize: textSize),
                          ),
                          ...(icon != null
                              ? [const SizedBox(width: 8), icon!]
                              : []),
                        ],
                      )
                    : const SizedBox.shrink()),
      ),
    );
  }
}
