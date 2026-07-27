import 'package:flutter/material.dart';

import '../../Amc_Model/amc_dashboard/recent_order_model.dart';


class RecentOrderCard extends StatelessWidget {
  final RecentOrderModel order;
  final VoidCallback? onTap;

  const RecentOrderCard({
    super.key,
    required this.order,
    this.onTap,
  });

  Color get statusColor {
    switch (order.bookingStatus.toLowerCase()) {
      case "completed":
        return Colors.green;

      case "assigned":
        return Colors.blue;

      case "searching":
        return Colors.orange;

      case "cancelled":
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  IconData get statusIcon {
    switch (order.bookingStatus.toLowerCase()) {
      case "completed":
        return Icons.check_circle;

      case "assigned":
        return Icons.person;

      case "searching":
        return Icons.search;

      case "cancelled":
        return Icons.cancel;

      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [

              /// Header
              Row(
                children: [

                  CircleAvatar(
                    backgroundColor: statusColor.withOpacity(.12),
                    child: Icon(
                      statusIcon,
                      color: statusColor,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          order.amcId,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          order.serviceName,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                        ),

                      ],
                    ),
                  ),

                  Chip(
                    backgroundColor:
                    statusColor.withOpacity(.12),
                    label: Text(
                      order.bookingStatus,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )

                ],
              ),

              const Divider(height: 28),

              _row(
                Icons.phone,
                "Customer",
                order.userPhone,
              ),

              _row(
                Icons.person,
                "Partner",
                order.partnerName ?? "Not Assigned",
              ),

              _row(
                Icons.calendar_today,
                "Date",
                order.date,
              ),

              _row(
                Icons.access_time,
                "Time",
                order.timeSlot,
              ),

              _row(
                Icons.currency_rupee,
                "Amount",
                "₹${order.price}",
              ),

              const SizedBox(height: 15),

              Align(
                alignment: Alignment.centerRight,
                child: FilledButton.icon(
                  onPressed: onTap,
                  icon: const Icon(Icons.visibility),
                  label: const Text("View Details"),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _row(
      IconData icon,
      String title,
      String value,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [

          Icon(
            icon,
            size: 18,
            color: Colors.blue,
          ),

          const SizedBox(width: 10),

          SizedBox(
            width: 85,
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