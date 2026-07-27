import 'package:flutter/material.dart';
import '../../Amc_Model/amc_order_model.dart';

class OrderServiceCard extends StatelessWidget {
  final AmcOrderModel order;

  const OrderServiceCard({super.key, required this.order});

  Color get statusColor {
    switch (order.status.toLowerCase()) {
      case "pending":
        return Colors.orange;

      case "assigned":
        return Colors.blue;

      case "completed":
        return Colors.green;

      case "cancelled":
        return Colors.red;

      case "searching":
        return Colors.deepPurple;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.home_repair_service, color: Colors.blue),

                SizedBox(width: 10),

                Text(
                  "Service Details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const Divider(height: 25),

            _infoRow(Icons.build, "Service", order.serviceName),

            _infoRow(Icons.description, "Description", order.description),

            _infoRow(Icons.location_on, "Address", order.address),

            _infoRow(
              Icons.currency_rupee,
              "Price",
              "₹${order.price.toStringAsFixed(0)}",
            ),

            _infoRow(Icons.payments, "Payment", order.payment),

            const SizedBox(height: 15),

            Row(
              children: [
                const Text(
                  "Booking Status",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                const Spacer(),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(.15),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    order.bookingStatus,
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

  Widget _infoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.blue),

          const SizedBox(width: 10),

          SizedBox(
            width: 95,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),

          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
