import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showYearPicker(BuildContext context, TextEditingController ctrl) {
  int? currentYear = int.tryParse(ctrl.text);
  int initialYear = currentYear ?? 1403;
  int initialIndex = (initialYear - 1300).clamp(0, 200);

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: 250,
        decoration: const BoxDecoration(
          color: CupertinoColors.systemBackground,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'تایید',
                    style: TextStyle(fontSize: 15),
                  ),
                )
              ],
            ),
            Expanded(
              child: CupertinoPicker(
                scrollController:
                    FixedExtentScrollController(initialItem: initialIndex),
                itemExtent: 45,
                onSelectedItemChanged: (index) {
                  int year = 1300 + index;
                  ctrl.text = year.toString();
                },
                children: List.generate(111, (index) => 1300 + index)
                    .map(
                      (year) => Center(
                        child: Text(
                          year.toString(),
                          style: const TextStyle(
                            fontSize: 22,
                            fontFamily: "Shabnam",
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      );
    },
  );
}
