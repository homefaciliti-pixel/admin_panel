import 'package:flutter/material.dart';
import '../../Amc_Model/partner_payment_model.dart';

class PaymentHeaderCard extends StatelessWidget {
  final PartnerPaymentModel payment;

  const PaymentHeaderCard({
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

  IconData get statusIcon {
    switch (payment.status) {
      case "Paid":
        return Icons.check_circle;

      case "Pending":
        return Icons.pending_actions;

      case "Processing":
        return Icons.sync;

      case "Failed":
        return Icons.cancel;

      default:
        return Icons.info;
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
        child: Row(
          children: [

            CircleAvatar(
              radius: 32,
              backgroundColor: statusColor.withOpacity(.15),
              child: Icon(
                statusIcon,
                color: statusColor,
                size: 32,
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Text(
                    payment.paymentId,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "Order : ${payment.orderId}",
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  Text(
                    "AMC : ${payment.amcId}",
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [

                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.grey,
                      ),

                      const SizedBox(width: 6),

                      Text(payment.paymentDate),

                    ],
                  ),

                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(.15),
                borderRadius: BorderRadius.circular(25),
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
    );
  }
}