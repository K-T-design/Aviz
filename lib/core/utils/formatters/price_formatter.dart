import 'package:aviz/core/utils/extensions/price_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PriceFormatter {
  static format(TextEditingController controller) {
    final text = controller.text.replaceAll(',', '');
    if (text.isEmpty) return;

    final selection = controller.selection;
    final cursorPosition = selection.extentOffset;

    final parsed = num.tryParse(text) ?? 0;
    final formatted = parsed.toPrice();

    int offset = formatted.length;
    if (cursorPosition > text.length) {
      offset = formatted.length;
    } else {
      final oldTextBeforeCursor = text.substring(0, cursorPosition);
      final newTextBeforeCursor =
          (num.tryParse(oldTextBeforeCursor) ?? 0).toPrice();
      offset = newTextBeforeCursor.length;
    }

    controller.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: offset),
    );
  }

  static List<TextInputFormatter> get inputFormatters => [
        FilteringTextInputFormatter.digitsOnly,
      ];
}
