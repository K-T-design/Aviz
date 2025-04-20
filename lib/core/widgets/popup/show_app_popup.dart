import 'package:flutter/material.dart';

Future<void> showAppPopup(
  BuildContext context, {
  required String title,
  required Widget content,
  String closeLabel = 'بستن',
  bool barrierDismissible = true,
}) {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (_) => AlertDialog(
      title: Column(
        children: [
          Text(title, textAlign: TextAlign.center),
          const Divider(),
        ],
      ),
      content: SingleChildScrollView(child: content),
      backgroundColor: Colors.white,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(closeLabel),
        ),
      ],
    ),
  );
}
