import 'package:flutter/material.dart';
import '../../Amc_Model/partner_payment_model.dart';

class PaymentPartnerCard extends StatelessWidget {
  final PartnerPaymentModel payment;

  const PaymentPartnerCard({
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
                  Icons.person,
                  color: Colors.blue,
                ),

                SizedBox(width: 10),

                Text(
                  "Partner Information",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),

            const Divider(height: 25),

            Row(
              children: [

                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue.shade100,
                  child: const Icon(
                    Icons.person,
                    size: 32,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        payment.partnerName,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        payment.partnerPhone,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            ),

            const SizedBox(height: 20),

            _infoRow(
              Icons.badge,
              "Partner ID",
              payment.partnerId,
            ),

            _infoRow(
              Icons.receipt_long,
              "Order ID",
              payment.orderId,
            ),

            _infoRow(
              Icons.confirmation_number,
              "AMC ID",
              payment.amcId,
            ),

            _infoRow(
              Icons.shopping_bag,
              "Total Orders",
              "${payment.totalOrders}",
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
            width: 110,
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