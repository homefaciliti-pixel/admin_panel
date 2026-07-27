import 'package:flutter/material.dart';

import '../../Amc_Model/amc_dashboard/dashboard_model.dart';
import '../Amc_card/dashboard_stat_card.dart';
import 'dashboard_section_title.dart';

class DashboardAmcOverview extends StatelessWidget {

  final DashboardAmcModel dashboard;

  const DashboardAmcOverview({
    super.key,
    required this.dashboard,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const DashboardSectionTitle(
          title: "AMC Overview",
          icon: Icons.dashboard_customize,
        ),

        const SizedBox(height: 18),

        LayoutBuilder(
          builder: (context, constraints) {

            int crossAxisCount = 4;

            if (constraints.maxWidth < 1100) {
              crossAxisCount = 2;
            }

            if (constraints.maxWidth < 650) {
              crossAxisCount = 1;
            }

            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 18,
              crossAxisSpacing: 18,
              childAspectRatio: 1.45,

              children: [

                DashboardSummaryCard(
                  title: "Total AMC",
                  value: dashboard.totalAmc.toString(),
                  icon: Icons.inventory_2_outlined,
                  color: Colors.blue,
                  subtitle: "Overall AMC",
                ),

                DashboardSummaryCard(
                  title: "Active AMC",
                  value: dashboard.activeAmc.toString(),
                  icon: Icons.workspace_premium,
                  color: Colors.green,
                  subtitle: "Running Plans",
                ),

                DashboardSummaryCard(
                  title: "Expired",
                  value: dashboard.expiredAmc.toString(),
                  icon: Icons.cancel_outlined,
                  color: Colors.red,
                  subtitle: "Need Renewal",
                ),

                DashboardSummaryCard(
                  title: "Renew Due",
                  value: "₹${dashboard.revenue.toStringAsFixed(0)}",
                  icon: Icons.refresh,
                  color: Colors.orange,
                  subtitle: "Next 7 Days",
                ),

              ],
            );
          },
        ),

      ],
    );
  }
}