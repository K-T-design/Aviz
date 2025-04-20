import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FormTextField extends StatelessWidget {
  const FormTextField({
    super.key,
    this.controller,
    this.hintText,
    this.validator,
    this.onTap,
    this.readOnly = false,
    this.isNumField = true,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String? value)? validator;
  final void Function()? onTap;
  final bool readOnly;
  final bool isNumField;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      onTap: onTap,
      readOnly: readOnly,
      keyboardType: isNumField ? TextInputType.number : null,
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade50,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
        isDense: true,
        suffixIcon: isNumField
            ? Transform.scale(
                scale: 0.5,
                child: SvgPicture.asset('assets/icons/inc_dec.svg'),
              )
            : null,
        constraints: BoxConstraints.tight(const Size.fromHeight(70)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.grey.shade100),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Colors.red),
        ),
        helperText: '',
        helperStyle: const TextStyle(
          fontSize: 11,
          height: 1.5,
          color: Colors.transparent,
        ),
        errorStyle: const TextStyle(
          fontSize: 11,
          height: 1.5,
          color: Colors.red,
        ),
      ),
    );
  }
}
