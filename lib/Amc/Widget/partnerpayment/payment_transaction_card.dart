import 'package:flutter/material.dart';
import '../../Amc_Model/partner_payment_model.dart';

class PaymentTransactionCard extends StatelessWidget {
  final PartnerPaymentModel payment;

  const PaymentTransactionCard({
    super.key,
    required this.payment,
  });

  Color get statusColor {
    switch (payment.status) {
      case "Paid":
        return Colors.green;

      case "Pending":
        return Colors.orange;

      case "Processing":
        return Colors.blue;

      case "Failed":
        return Colors.red;

      default:
        return Colors.grey;
    }
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

            const Row(
              children: [

                Icon(
                  Icons.receipt_long,
                  color: Colors.deepPurple,
                ),

                SizedBox(width: 10),

                Text(
                  "Transaction Details",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),

            const Divider(height: 25),

            _infoRow(
              Icons.payment,
              "Method",
              payment.paymentMethod,
            ),

            _infoRow(
              Icons.numbers,
              "Transaction ID",
              payment.transactionId.isEmpty
                  ? "Not Generated"
                  : payment.transactionId,
            ),

            _infoRow(
              Icons.calendar_today,
              "Payment Date",
              payment.paymentDate,
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [

                  const Icon(
                    Icons.verified,
                    color: Colors.blue,
                    size: 18,
                  ),

                  const SizedBox(width: 10),

                  const SizedBox(
                    width: 120,
                    child: Text(
                      "Status",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      payment.status,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
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

  Widget _infoRow(
      IconData icon,
      String title,
      String value,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [

          Icon(
            icon,
            color: Colors.blue,
            size: 18,
          ),

          const SizedBox(width: 10),

          SizedBox(
            width: 120,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Expanded(
            child: Text(value),
          ),

        ],
      ),
    );
  }
}