import 'package:aviz/core/navigation/args/post_detail_page_args.dart';
import 'package:flutter/material.dart';

class FacilityItemColumn extends StatelessWidget {
  const FacilityItemColumn({
    super.key,
    required this.args,
  });

  final PostDetailPageArgs args;

  @override
  Widget build(BuildContext context) {
    final hasElevator = args.post.hasElevator!;
    final hasParking = args.post.hasParking!;
    final hasBasement = args.post.hasBasement!;

    final facilityItems = [
      {'title': 'آسانسور', 'has': hasElevator},
      {'title': 'پارکینگ', 'has': hasParking},
      {'title': 'انباری', 'has': hasBasement},
    ];

    final visibleItems =
        facilityItems.where((item) => item['has'] as bool).toList();

    if (visibleItems.isEmpty) {
      return const Center(
        child: Text('موردی ثبت نشده است'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < visibleItems.length; i++)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  visibleItems[i]['title'] as String,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
              // Add divider if it's not the last item
              if (i < visibleItems.length - 1) const Divider(),
            ],
          ),
      ],
    );
  }
}
