import 'package:flutter/material.dart';


import '../../Amc_Model/amc_dashboard/dashboard_model.dart';
import '../Amc_card/dashboard_stat_card.dart';
import 'dashboard_section_title.dart';

class DashboardOperationsSection extends StatelessWidget {
  final DashboardAmcModel dashboard;

  const DashboardOperationsSection({
    super.key,
    required this.dashboard,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const DashboardSectionTitle(
          title: "Today's Operations",
          icon: Icons.build_circle_outlined,
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
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
              childAspectRatio: 1.45,

              children: [

                DashboardSummaryCard(
                  title: "Total Visits",
                  value: dashboard.totalVisits.toString(),
                  icon: Icons.shopping_bag_outlined,
                  color: Colors.blue,
                  subtitle: "All Visits",
                ),

                DashboardSummaryCard(
                  title: "Today's Visits",
                  value: dashboard.todayVisits.toString(),
                  icon: Icons.calendar_today,
                  color: Colors.green,
                  subtitle: "Today's Schedule",
                ),

                DashboardSummaryCard(
                  title: "Pending Visits",
                  value: dashboard.pendingVisits.toString(),
                  icon: Icons.pending_actions,
                  color: Colors.orange,
                  subtitle: "Need Attention",
                ),

                const DashboardSummaryCard(
                  title: "Completed Visits",
                  value: "0",
                  icon: Icons.check_circle_outline,
                  color: Colors.purple,
                  subtitle: "Completed Today",
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}