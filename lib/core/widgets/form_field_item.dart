import 'package:flutter/material.dart';

class FormFieldItem extends StatelessWidget {
  const FormFieldItem({
    super.key,
    required this.title,
    required this.textField,
  });

  final String title;
  final Widget textField;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
        textField,
      ],
    );
  }
}
