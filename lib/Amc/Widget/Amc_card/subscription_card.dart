import 'package:flutter/material.dart';

import '../../Amc_Model/active_amc_model.dart';

class SubscriptionCard extends StatelessWidget {
  final ActiveAmcModel amc;


  const SubscriptionCard({super.key,required this.amc,});

  Widget row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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

            const Text(
              "💰 Subscription Details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Divider(),

            row("Plan", "Premium AMC"),

            row("Amount", "₹3500"),

            row("Payment", "Paid"),

            row("Start Date", "15 Jul 2026"),

            row("Expiry", "15 Jul 2027"),

          ],
        ),
      ),
    );
  }
}