import 'package:aviz/core/theme/app_sizes.dart';
import 'package:flutter/material.dart';

class AttributeSwitch extends StatelessWidget {
  const AttributeSwitch({
    super.key,
    required this.title,
    required this.onChanged,
    this.isOn = true,
  });

  final String title;
  final bool isOn;
  final void Function(bool value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onChanged?.call(!isOn),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Transform.scale(
        scale: 0.6,
        child: Switch(
          inactiveTrackColor: Colors.white,
          value: isOn,
          onChanged: onChanged,
          padding: EdgeInsets.zero,
        ),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: AppSizes.pageHorizontal),
      visualDensity: VisualDensity.compact,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade300),
      ),
    );
  }
}
