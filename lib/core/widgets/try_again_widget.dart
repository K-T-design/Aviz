import 'package:flutter/material.dart';

class TryAgainWidget extends StatelessWidget {
  const TryAgainWidget({
    super.key,
    this.title,
    this.buttonTitle,
    this.onPressed,
  });

  final String? title;
  final String? buttonTitle;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Text(
            title ?? "مشکلی پیش آمده، لطفا دوباره امتحان کنید",
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            onPressed: onPressed,
            child: Text(buttonTitle ?? 'تلاش دوباره'),
          ),
        ],
      ),
    );
  }
}
