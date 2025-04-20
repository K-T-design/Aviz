import 'package:flutter/material.dart';

class PostAttribute extends StatelessWidget {
  const PostAttribute({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.grey),
        ),
        Text(
          value,
        ),
      ],
    );
  }
}
