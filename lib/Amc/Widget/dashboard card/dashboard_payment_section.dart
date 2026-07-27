import 'package:flutter/material.dart';

import '../../Amc_Model/amc_dashboard/dashboard_model.dart';
import '../Amc_card/dashboard_stat_card.dart';
import 'dashboard_section_title.dart';

class DashboardPaymentSection extends StatelessWidget {
  final DashboardAmcModel dashboard;

  const DashboardPaymentSection({
    super.key,
    required this.dashboard,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const DashboardSectionTitle(
          title: "Payment Overview",
          icon: Icons.account_balance_wallet_outlined,
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
                  title: "Revenue",
                  value: "₹${dashboard.revenue.toStringAsFixed(0)}",
                  icon: Icons.currency_rupee,
                  color: Colors.green,
                  subtitle: "Total Revenue",
                ),

                DashboardSummaryCard(
                  title: "Pending Payment",
                  value: "₹${dashboard.pendingPayment.toStringAsFixed(0)}",
                  icon: Icons.payments_outlined,
                  color: Colors.orange,
                  subtitle: "Need Settlement",
                ),

                 DashboardSummaryCard(
                  title: "Partner Payout",
                   value: "₹${dashboard.partnerPayout.toStringAsFixed(0)}",
                  icon: Icons.account_balance,
                  color: Colors.blue,
                  subtitle: "This Month",
                ),

                 DashboardSummaryCard(
                  title: "Today's Collection",
                   value: "₹${dashboard.todayCollection.toStringAsFixed(0)}",
                  icon: Icons.wallet,
                  color: Colors.purple,
                  subtitle: "Today's Income",
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}