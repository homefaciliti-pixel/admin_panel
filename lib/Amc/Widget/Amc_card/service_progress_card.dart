import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common resuse/app_section_title.dart';

class ServiceProgressCard extends StatelessWidget {
  final int totalVisits;
  final int completedVisits;

  const ServiceProgressCard({
    super.key,
    required this.totalVisits,
    required this.completedVisits,
  });

  @override
  Widget build(BuildContext context) {

    final remaining = totalVisits - completedVisits;
    final progress = completedVisits / totalVisits;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const AppSectionTitle(
              title: "📊 Service Progress",
            ),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 10,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              "$completedVisits / $totalVisits Services Completed",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              "$remaining Visits Remaining",
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}