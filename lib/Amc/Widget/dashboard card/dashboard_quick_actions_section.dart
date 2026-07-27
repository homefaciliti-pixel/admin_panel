import 'package:flutter/material.dart';

import 'dashboard_quick_action_card.dart';
import 'dashboard_section_title.dart';

class DashboardQuickActionsSection extends StatelessWidget {
  final VoidCallback? onActiveAmc;
  final VoidCallback? onOrders;
  final VoidCallback? onVisits;
  final VoidCallback? onPayments;
  final VoidCallback? onExpiredAmc;
  final VoidCallback? onRenewAmc;

  const DashboardQuickActionsSection({
    super.key,
    this.onActiveAmc,
    this.onOrders,
    this.onVisits,
    this.onPayments,
    this.onExpiredAmc,
    this.onRenewAmc,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      (
      title: "Active AMC",
      icon: Icons.workspace_premium,
      color: Colors.green,
      onTap: onActiveAmc,
      ),
      (
      title: "AMC Orders",
      icon: Icons.shopping_bag,
      color: Colors.blue,
      onTap: onOrders,
      ),
      (
      title: "Visit History",
      icon: Icons.history,
      color: Colors.orange,
      onTap: onVisits,
      ),
      (
      title: "Partner Payments",
      icon: Icons.payments,
      color: Colors.purple,
      onTap: onPayments,
      ),
      (
      title: "Expired AMC",
      icon: Icons.cancel_outlined,
      color: Colors.red,
      onTap: onExpiredAmc,
      ),
      (
      title: "Renew AMC",
      icon: Icons.refresh,
      color: Colors.teal,
      onTap: onRenewAmc,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DashboardSectionTitle(
          title: "Quick Actions",
          icon: Icons.flash_on,
        ),

        const SizedBox(height: 20),

        LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = 4;

            if (constraints.maxWidth < 1200) {
              crossAxisCount = 3;
            }

            if (constraints.maxWidth < 800) {
              crossAxisCount = 2;
            }

            if (constraints.maxWidth < 500) {
              crossAxisCount = 1;
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 18,
                mainAxisSpacing: 18,
                childAspectRatio: 1.15,
              ),
              itemBuilder: (context, index) {
                final item = items[index];

                return DashboardQuickActionCard(
                  title: item.title,
                  icon: item.icon,
                  color: item.color,
                  onTap: item.onTap ?? () {},
                );
              },
            );
          },
        ),
      ],
    );
  }
}