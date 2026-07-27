import 'package:flutter/material.dart';
import '../../Amc_Model/active_amc_model.dart';

class QuickActionCard extends StatelessWidget {
  final ActiveAmcModel amc;
  final bool isExpired;

  final VoidCallback? onBookService;
  final VoidCallback? onHistory;
  final VoidCallback? onInvoice;
  final VoidCallback? onRenew;

  const QuickActionCard({
    super.key,
    required this.amc,
    this.isExpired = false,
    this.onBookService,
    this.onHistory,
    this.onInvoice,
    this.onRenew,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Wrap(
          spacing: 15,
          runSpacing: 15,
          children: [

            /// Active AMC
            if (!isExpired)
              FilledButton.icon(
                onPressed: onBookService,
                icon: const Icon(Icons.build),
                label: const Text("Book Service"),
              ),

            /// Active AMC
            if (!isExpired)
              FilledButton.icon(
                onPressed: onHistory,
                icon: const Icon(Icons.history),
                label: const Text("Service History"),
              ),

            /// Both
            FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.blueGrey,
              ),
              onPressed: onInvoice,
              icon: const Icon(Icons.receipt_long),
              label: const Text("Invoice"),
            ),

            /// Expired AMC
            if (isExpired)
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                onPressed: onRenew,
                icon: const Icon(Icons.refresh),
                label: const Text("Renew AMC"),
              ),
          ],
        ),
      ),
    );
  }
}