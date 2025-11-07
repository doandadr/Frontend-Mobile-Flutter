import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';

class InfoItem {
  final Icon leading;
  final String label;
  final String value;

  const InfoItem({
    required this.leading,
    required this.label,
    required this.value,
  });
}

class InfoListCard extends StatelessWidget {
  final String title;
  final List<InfoItem> items;

  const InfoListCard({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Table(
              columnWidths: const {
                0: IntrinsicColumnWidth(),
                1: FixedColumnWidth(12),
                2: FlexColumnWidth(),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.top,
              children: items
                  .map(
                    (e) => TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              e.leading,
                              const SizedBox(width: 8),
                              Text(
                                e.label,
                                style: const TextStyle(
                                  color: AppColors.primaryDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            ':',
                            style: TextStyle(color: AppColors.primaryDark),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            e.value,
                            style: const TextStyle(
                              color: AppColors.primaryDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}