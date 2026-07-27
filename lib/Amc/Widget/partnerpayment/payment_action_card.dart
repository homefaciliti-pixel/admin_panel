import 'package:flutter/material.dart';
import '../../Amc_Model/partner_payment_model.dart';

class PaymentActionCard extends StatelessWidget {
  final PartnerPaymentModel payment;

  final VoidCallback? onMarkPaid;
  final VoidCallback? onGenerateInvoice;
  final VoidCallback? onDownloadReceipt;
  final VoidCallback? onPrintReceipt;

  const PaymentActionCard({
    super.key,
    required this.payment,
    this.onMarkPaid,
    this.onGenerateInvoice,
    this.onDownloadReceipt,
    this.onPrintReceipt,
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
                  Icons.settings,
                  color: Colors.blue,
                ),

                SizedBox(width: 10),

                Text(
                  "Payment Actions",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),

            const Divider(height: 25),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [

                if (payment.status != "Paid")
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: onMarkPaid,
                    icon: const Icon(Icons.check_circle),
                    label: const Text("Mark Paid"),
                  ),

                OutlinedButton.icon(
                  onPressed: onGenerateInvoice,
                  icon: const Icon(Icons.receipt_long),
                  label: const Text("Generate Invoice"),
                ),

                OutlinedButton.icon(
                  onPressed: onDownloadReceipt,
                  icon: const Icon(Icons.download),
                  label: const Text("Download"),
                ),

                OutlinedButton.icon(
                  onPressed: onPrintReceipt,
                  icon: const Icon(Icons.print),
                  label: const Text("Print"),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}