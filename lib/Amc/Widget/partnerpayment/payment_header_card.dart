import 'package:flutter/material.dart';
import '../../Amc_Model/partner_payment_model.dart';

class PaymentHeaderCard extends StatelessWidget {
  final PartnerPaymentModel payment;

  const PaymentHeaderCard({
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

  IconData get statusIcon {
    switch (payment.status.toLowerCase()) {
      case "released":
        return Icons.check_circle;

      case "pending":
        return Icons.pending_actions;

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "Payment #${payment.paymentId}",
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "Partner : ${payment.partnerName}",
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  Text(
                    "Phone : ${payment.partnerPhone}",
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

                  Text(
                    "Visit ID : ${payment.visitId}",
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

                      Text(
                        payment.createdAt
                            .toLocal()
                            .toString()
                            .split(" ")
                            .first,
                      ),

                    ],
                  ),

                  if (payment.releasedAt != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Row(
                        children: [

                          const Icon(
                            Icons.check_circle,
                            size: 16,
                            color: Colors.green,
                          ),

                          const SizedBox(width: 6),

                          Text(
                            "Released : ${payment.releasedAt!.toLocal().toString().split(' ').first}",
                          ),

                        ],
                      ),
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
                payment.status.toUpperCase(),
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