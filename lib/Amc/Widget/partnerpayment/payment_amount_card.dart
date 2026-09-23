import 'package:flutter/material.dart';
import '../../Amc_Model/partner_payment_model.dart';

class PaymentAmountCard extends StatelessWidget {
  final PartnerPaymentModel payment;

  const PaymentAmountCard({
    super.key,
    required this.payment,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Row(
              children: [

                Icon(
                  Icons.account_balance_wallet,
                  color: Colors.green,
                ),

                SizedBox(width: 10),

                Text(
                  "Payment Summary",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),

            const Divider(height: 25),

            _infoRow(
              "Partner",
              payment.partnerName,
            ),

            _infoRow(
              "AMC ID",
              payment.amcId,
            ),

            _infoRow(
              "Visit ID",
              payment.visitId.toString(),
            ),

            _amountRow(
              "Amount",
              payment.amount,
              Colors.green,
              isBold: true,
            ),

            const Divider(),

            _infoRow(
              "Status",
              payment.status.toUpperCase(),
            ),

            _infoRow(
              "Created",
              payment.createdAt
                  .toLocal()
                  .toString()
                  .split(" ")
                  .first,
            ),

            if (payment.releasedAt != null)
              _infoRow(
                "Released",
                payment.releasedAt!
                    .toLocal()
                    .toString()
                    .split(" ")
                    .first,
              ),

          ],
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),

          const Spacer(),

          Text(value),

        ],
      ),
    );
  }

  Widget _amountRow(
      String title,
      double amount,
      Color color, {
        bool isBold = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [

          Text(
            title,
            style: TextStyle(
              fontWeight:
              isBold ? FontWeight.bold : FontWeight.w600,
            ),
          ),

          const Spacer(),

          Text(
            "₹${amount.toStringAsFixed(2)}",
            style: TextStyle(
              color: color,
              fontSize: 17,
              fontWeight:
              isBold ? FontWeight.bold : FontWeight.w700,
            ),
          ),

        ],
      ),
    );
  }
}