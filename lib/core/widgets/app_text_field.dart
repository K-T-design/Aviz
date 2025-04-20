import 'package:aviz/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.textController,
    required this.hintText,
    this.keyboardType,
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.maxLines,
    this.inputFormatters,
  });

  final TextEditingController textController;
  final String? hintText;
  final TextInputType? keyboardType;
  final String? Function(String? value)? validator;
  final TextInputAction textInputAction;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      maxLines: maxLines,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      keyboardType: keyboardType,
      validator: validator,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.subtitle,
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.hint),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
}
