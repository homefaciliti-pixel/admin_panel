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

            _amountRow(
              "Service Amount",
              payment.serviceAmount,
              Colors.black,
            ),

            _amountRow(
              "Platform Commission",
              payment.commission,
              Colors.red,
            ),

            const Divider(),

            _amountRow(
              "Payable Amount",
              payment.payableAmount,
              Colors.green,
              isBold: true,
            ),

            const SizedBox(height: 18),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [

                  const Icon(
                    Icons.account_balance,
                    color: Colors.green,
                  ),

                  const SizedBox(width: 10),

                  const Text(
                    "Payment Method",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Spacer(),

                  Text(
                    payment.paymentMethod,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),
            ),

          ],
        ),
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
              fontSize: 15,
              fontWeight:
              isBold ? FontWeight.bold : FontWeight.w500,
            ),
          ),

          const Spacer(),

          Text(
            "₹${amount.toStringAsFixed(0)}",
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight:
              isBold ? FontWeight.bold : FontWeight.w600,
            ),
          ),

        ],
      ),
    );
  }
}