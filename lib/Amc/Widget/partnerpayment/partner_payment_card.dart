import 'package:flutter/material.dart';
import '../../Amc_Model/partner_payment_model.dart';

class PartnerPaymentCard extends StatelessWidget {
  final PartnerPaymentModel payment;

  final VoidCallback? onView;
  final VoidCallback? onMarkPaid;

  const PartnerPaymentCard({
    super.key,
    required this.payment,
    this.onView,
    this.onMarkPaid,
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
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 18),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        onTap: onView,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Header
              Row(
                children: [

                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.blue.shade100,
                    child: const Icon(
                      Icons.person,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        Text(
                          payment.partnerName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          payment.partnerPhone,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),

                        Text(
                          "Payment ID : ${payment.paymentId}",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),

                      ],
                    ),
                  ),

                  Chip(
                    backgroundColor:
                    statusColor.withOpacity(.15),
                    label: Text(
                      payment.status,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 20),

              Wrap(
                spacing: 35,
                runSpacing: 15,
                children: [

                  _info(
                    Icons.currency_rupee,
                    "Payable",
                    "₹${payment.payableAmount.toStringAsFixed(0)}",
                  ),

                  _info(
                    Icons.receipt_long,
                    "Orders",
                    "${payment.totalOrders}",
                  ),

                  _info(
                    Icons.calendar_today,
                    "Date",
                    payment.paymentDate,
                  ),

                  _info(
                    Icons.account_balance,
                    "Method",
                    payment.paymentMethod,
                  ),

                ],
              ),

              const SizedBox(height: 20),

              if (payment.transactionId.isNotEmpty)
                Row(
                  children: [

                    const Icon(
                      Icons.receipt,
                      size: 18,
                      color: Colors.blue,
                    ),

                    const SizedBox(width: 8),

                    Text(
                      "Txn : ${payment.transactionId}",
                    ),

                  ],
                ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  OutlinedButton.icon(
                    onPressed: onView,
                    icon: const Icon(Icons.visibility),
                    label: const Text("View Details"),
                  ),

                  const SizedBox(width: 10),

                  if (payment.status != "Paid")
                    FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: onMarkPaid,
                      icon: const Icon(Icons.check_circle),
                      label: const Text("Mark Paid"),
                    ),

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _info(
      IconData icon,
      String title,
      String value,
      ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [

        Icon(
          icon,
          size: 18,
          color: Colors.blue,
        ),

        const SizedBox(width: 6),

        Text(
          "$title : ",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(value),

      ],
    );
  }
}