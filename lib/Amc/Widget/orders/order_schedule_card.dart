import 'package:flutter/material.dart';
import '../../Amc_Model/amc_order_model.dart';

class OrderScheduleCard extends StatelessWidget {
  final AmcOrderModel order;

  const OrderScheduleCard({super.key, required this.order});

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
                Icon(Icons.event_available, color: Colors.blue),

                SizedBox(width: 10),

                Text(
                  "Schedule Details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const Divider(height: 25),

            _infoRow(Icons.calendar_today, "Booking Date", order.date),

            _infoRow(Icons.access_time, "Booking Time", order.timeSlot ?? "-"),

            _infoRow(
              Icons.confirmation_number,
              "Order ID",
              order.id.toString(),
            ),

            _infoRow(Icons.assignment, "AMC ID", order.amcId),

            _infoRow(Icons.info_outline, "Status", order.status),

            _infoRow(
              Icons.assignment_turned_in,
              "Booking",
              order.bookingStatus,
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
            width: 120,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),

          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
