import 'package:flutter/material.dart';

import '../Amc_Model/active_amc_model.dart';
import '../Widget/Amc_card/admin_notes_card.dart';
import '../Widget/Amc_card/customer_profile_card.dart';
import '../Widget/Amc_card/partner_card.dart';
import '../Widget/Amc_card/property_details_card.dart';
import '../Widget/Amc_card/quick_action_card.dart';
import '../Widget/Amc_card/recent_service_history_card.dart';
import '../Widget/Amc_card/service_progress_card.dart';
import '../Widget/Amc_card/subscription_card.dart';

class AdminAmcDetailsView extends StatelessWidget {
  final ActiveAmcModel amc;
  final bool isExpired;

  const AdminAmcDetailsView({
    super.key,
    required this.amc,
    this.isExpired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        title: Text(
          isExpired ? "Expired AMC Details" : "AMC Details",
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            CustomerProfileCard(
              amc: amc,
              isExpired: isExpired,
            ),

            const SizedBox(height: 20),

            PropertyDetailsCard(
              amc: amc,
            ),

            const SizedBox(height: 20),

            SubscriptionCard(
              amc: amc,
            ),

            const SizedBox(height: 20),

            PartnerCard(
              amc: amc,
            ),

            const SizedBox(height: 20),

            ServiceProgressCard(
              totalVisits: amc.totalVisits,
              completedVisits: amc.completedVisits,
            ),

            const SizedBox(height: 20),

            QuickActionCard(
              amc: amc,
              isExpired: isExpired,
            ),

            const SizedBox(height: 20),

            RecentServiceHistoryCard(
              amcId: amc.amcId,
            ),

            const SizedBox(height: 20),

            AdminNotesCard(
              amc: amc,
            ),

          ],
        ),
      ),
    );
  }
}