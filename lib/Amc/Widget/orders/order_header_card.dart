import 'package:flutter/material.dart';
import '../../Amc_Model/amc_order_model.dart';

class OrderHeaderCard extends StatelessWidget {
  final AmcOrderModel order;

  const OrderHeaderCard({super.key, required this.order});

  Color get statusColor {
    switch (order.status.toLowerCase()) {
      case "pending":
        return Colors.orange;

      case "assigned":
        return Colors.blue;

      case "in progress":
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            CircleAvatar(
              radius: 34,
              backgroundColor: Colors.blue.shade100,
              child: const Icon(
                Icons.home_repair_service,
                size: 34,
                color: Colors.blue,
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.serviceName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "Order ID : ${order.id}",
                    style: const TextStyle(color: Colors.grey),
                  ),

                  Text(
                    "AMC ID : ${order.amcId}",
                    style: const TextStyle(color: Colors.grey),
                  ),

                  Text(
                    order.userPhone,
                    style: const TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    order.address,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
      ),
    );
  }
}
