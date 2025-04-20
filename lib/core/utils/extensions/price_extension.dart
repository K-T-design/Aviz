import 'package:intl/intl.dart';

extension PriceExtensionOnNum on num {
  String toPrice() {
    final formatter = NumberFormat('#,##0', 'en_US');
    return formatter.format(this);
  }
}

extension PriceExtensionOnString on String {
  num fromPrice() {
    final cleanString = replaceAll(',', '');
    return num.tryParse(cleanString) ?? 0;
  }
}
