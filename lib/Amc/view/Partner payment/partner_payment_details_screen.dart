import 'package:flutter/material.dart';

import '../../Amc_Model/partner_payment_model.dart';
import '../../Widget/partnerpayment/payment_action_card.dart';
import '../../Widget/partnerpayment/payment_amount_card.dart';
import '../../Widget/partnerpayment/payment_header_card.dart';
import '../../Widget/partnerpayment/payment_partner_card.dart';
import '../../Widget/partnerpayment/payment_transaction_card.dart';



class PartnerPaymentDetailsScreen extends StatelessWidget {
  final PartnerPaymentModel payment;

  const PartnerPaymentDetailsScreen({
    super.key,
    required this.payment,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        title: const Text("Payment Details"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            PaymentHeaderCard(
              payment: payment,
            ),

            const SizedBox(height: 20),

            PaymentPartnerCard(
              payment: payment,
            ),

            const SizedBox(height: 20),

            PaymentAmountCard(
              payment: payment,
            ),

            const SizedBox(height: 20),

            PaymentTransactionCard(
              payment: payment,
            ),

            const SizedBox(height: 20),

            PaymentActionCard(
              payment: payment,
            ),

          ],
        ),
      ),
    );
  }
}


