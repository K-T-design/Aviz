import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class AppSnackBar {
  static final _toast = FToast();

  static init(BuildContext context) {
    _toast.init(context);
  }

  static Widget _toastWidget(String message, Color color) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.error,
              color: Colors.white,
            ),
          ],
        ),
      );

  static showSuccess(String message) {
    _toast.showToast(
      child: _toastWidget(message, Colors.green),
      gravity: ToastGravity.TOP,
    );
  }

  static showError(String message) {
    _toast.showToast(
      child: _toastWidget(message, Colors.red),
      gravity: ToastGravity.TOP,
    );
  }

  static showSimpleError(String message, {Duration? duration}) {
    _toast.removeQueuedCustomToasts();
    _toast.showToast(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        alignment: Alignment.centerRight,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      gravity: ToastGravity.SNACKBAR,
      isDismissible: false,
      toastDuration: duration ?? const Duration(seconds: 10),
    );
  }
}
