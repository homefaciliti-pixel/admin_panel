import 'package:flutter/material.dart';
import '../../Amc_Model/active_amc_model.dart';
import '../common resuse/app_info_card.dart';
import '../common resuse/app_section_title.dart';

class VisitSummaryCard extends StatelessWidget {
  final ActiveAmcModel amc;

  const VisitSummaryCard({
    super.key,
    required this.amc,
  });

  Widget summaryItem({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.2,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: color.withOpacity(.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: color.withOpacity(.25),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 28, color: color),
              const SizedBox(height: 8),

              Flexible(
                child: Text(
                  value,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 6),

              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final remaining =
        amc.totalVisits - amc.completedVisits;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const AppSectionTitle(
          title: "Visit Summary",
        ),

        const SizedBox(height: 15),

        Row(
          children: [

            Expanded(
              child: AppInfoCard(
                icon: Icons.list_alt,
                title: "Total Visits",
                value: "${amc.totalVisits}",
                color: Colors.blue,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: AppInfoCard(
                icon: Icons.check_circle,
                title: "Completed",
                value: "${amc.completedVisits}",
                color: Colors.green,
              ),
            ),

          ],
        ),

        const SizedBox(height: 15),

        Row(
          children: [
            Expanded(
              child: AppInfoCard(
                icon: Icons.schedule,
                title: "Remaining",
                value: "$remaining",
                color: Colors.orange,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: AppInfoCard(
                icon: Icons.calendar_month,
                title: "Expiry",
                value: amc.endDate,
                color: Colors.red,
              ),
            ),

          ],
        ),
      ],
    );
  }
}