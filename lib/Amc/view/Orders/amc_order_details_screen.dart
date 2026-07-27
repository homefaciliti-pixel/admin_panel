import 'package:flutter/material.dart';

import '../../Amc_Model/amc_order_model.dart';
import '../../Widget/orders/order_header_card.dart';
import '../../Widget/orders/order_schedule_card.dart';
import '../../Widget/orders/order_service_card.dart';
import '../../Widget/orders/partner_details_card.dart';

class AmcOrderDetailsScreen extends StatelessWidget {
  final AmcOrderModel order;

  const AmcOrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(title: const Text("Order Details")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// Customer Header
            OrderHeaderCard(order: order),

            const SizedBox(height: 20),

            /// Service Details
            OrderServiceCard(order: order),

            const SizedBox(height: 20),

            /// Schedule
            OrderScheduleCard(order: order),

            const SizedBox(height: 20),

            /// Partner Details
            PartnerDetailsCard(
              partnerName: (order.partnerName ?? "").isEmpty
                  ? "Not Assigned"
                  : order.partnerName!,

              partnerPhone: order.partnerPhone ?? "No Phone",

              partnerRating: order.partnerRating ?? 0,

              partnerStatus: order.partnerStatus ?? "Not Assigned",

              onCallPartner: (order.partnerPhone ?? "").isEmpty
                  ? null
                  : () {
                      // TODO Call Partner
                    },

              onChangePartner: () {
                // TODO Reassign Partner
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
