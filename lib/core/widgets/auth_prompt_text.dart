import 'package:aviz/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AuthPromptText extends StatelessWidget {
  const AuthPromptText({
    super.key,
    required this.promptText,
    required this.actionText,
    required this.onAction,
  });

  final String promptText;
  final String actionText;
  final void Function()? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          promptText,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GestureDetector(
            onTap: onAction,
            child: Text(
              actionText,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
