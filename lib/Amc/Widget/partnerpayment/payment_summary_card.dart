import 'package:flutter/material.dart';

class PaymentSummaryCard extends StatelessWidget {
  final double pendingAmount;
  final double paidAmount;
  final int totalPartners;
  final int totalPayments;

  const PaymentSummaryCard({
    super.key,
    required this.pendingAmount,
    required this.paidAmount,
    required this.totalPartners,
    required this.totalPayments,
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
        child: Row(
          children: [

            Expanded(
              child: _item(
                Icons.pending_actions,
                Colors.orange,
                "Pending",
                "₹${pendingAmount.toStringAsFixed(0)}",
              ),
            ),

            Expanded(
              child: _item(
                Icons.check_circle,
                Colors.green,
                "Paid",
                "₹${paidAmount.toStringAsFixed(0)}",
              ),
            ),

            Expanded(
              child: _item(
                Icons.people,
                Colors.blue,
                "Partners",
                "$totalPartners",
              ),
            ),

            Expanded(
              child: _item(
                Icons.receipt_long,
                Colors.purple,
                "Payments",
                "$totalPayments",
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _item(
      IconData icon,
      Color color,
      String title,
      String value,
      ) {
    return Column(
      children: [

        CircleAvatar(
          radius: 24,
          backgroundColor: color.withOpacity(.12),
          child: Icon(
            icon,
            color: color,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),

      ],
    );
  }
}