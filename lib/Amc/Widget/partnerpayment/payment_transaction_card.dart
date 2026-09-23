import 'package:flutter/material.dart';
import '../../Amc_Model/partner_payment_model.dart';

class PaymentTransactionCard extends StatelessWidget {
  final PartnerPaymentModel payment;

  const PaymentTransactionCard({
    super.key,
    required this.payment,
  });

  Color get statusColor {
    switch (payment.status.toLowerCase()) {
      case "released":
        return Colors.green;

      case "pending":
        return Colors.orange;

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
              "Payment ID",
              payment.paymentId.toString(),
            ),

            _infoRow(
              Icons.receipt,
              "Razorpay Payment",
              payment.razorpayPaymentId ?? "N/A",
            ),

            _infoRow(
              Icons.shopping_bag,
              "Razorpay Order",
              payment.razorpayOrderId ?? "N/A",
            ),

            _infoRow(
              Icons.calendar_today,
              "Created",
              payment.createdAt
                  .toLocal()
                  .toString()
                  .split(" ")
                  .first,
            ),

            if (payment.releasedAt != null)
              _infoRow(
                Icons.check_circle,
                "Released",
                payment.releasedAt!
                    .toLocal()
                    .toString()
                    .split(" ")
                    .first,
              ),

            const SizedBox(height: 10),

            Row(
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
                    payment.status.toUpperCase(),
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              ],
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
            width: 130,
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