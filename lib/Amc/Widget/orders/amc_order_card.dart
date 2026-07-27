import 'package:flutter/material.dart';
import '../../Amc_Model/amc_order_model.dart';

class AmcOrderCard extends StatelessWidget {
  final AmcOrderModel order;

  final VoidCallback? onView;
  final VoidCallback? onAssignPartner;
  final VoidCallback? onUpdateStatus;

  const AmcOrderCard({
    super.key,
    required this.order,
    this.onView,
    this.onAssignPartner,
    this.onUpdateStatus,
  });

  Color get statusColor {
    switch (order.status.toLowerCase()) {
      case "pending":
        return Colors.orange;

      case "assigned":
        return Colors.blue;

      case "searching":
        return Colors.deepPurple;

      case "completed":
        return Colors.green;

      case "cancelled":
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.serviceName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        "AMC ID : ${order.amcId}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(.15),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    order.status.toUpperCase(),
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const Divider(height: 30),

            _info(Icons.phone, "Phone", order.userPhone),

            _info(Icons.home_repair_service, "Service", order.serviceName),

            _info(Icons.person, "Partner", order.partnerName ?? "Not Assigned"),

            _info(Icons.calendar_today, "Date", order.date),

            _info(Icons.access_time, "Time", order.timeSlot ?? "-"),

            _info(Icons.payments, "Payment", order.payment),

            _info(
              Icons.currency_rupee,
              "Price",
              "₹${order.price.toStringAsFixed(0)}",
            ),

            _info(Icons.assignment, "Booking", order.bookingStatus),

            const SizedBox(height: 20),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                FilledButton.icon(
                  onPressed: onView,
                  icon: const Icon(Icons.visibility),
                  label: const Text("View"),
                ),

                if (order.partnerName == null)
                  FilledButton.icon(
                    style: FilledButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: onAssignPartner,
                    icon: const Icon(Icons.person_add),
                    label: const Text("Assign"),
                  ),

                if (order.status.toLowerCase() != "completed")
                  OutlinedButton.icon(
                    onPressed: onUpdateStatus,
                    icon: const Icon(Icons.update),
                    label: const Text("Update Status"),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _info(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.blue),

          const SizedBox(width: 8),

          SizedBox(
            width: 90,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
