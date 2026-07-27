import 'package:flutter/material.dart';

import '../../Amc_Model/amc_dashboard/today_visit_model.dart';


class VisitCard extends StatelessWidget {
  final VisitModel visit;
  final VoidCallback? onTap;

  const VisitCard({
    super.key,
    required this.visit,
    this.onTap,
  });

  Color get statusColor {
    switch (visit.status.toLowerCase()) {
      case "completed":
        return Colors.green;

      case "assigned":
        return Colors.blue;

      case "pending":
        return Colors.orange;

      case "cancelled":
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  IconData get statusIcon {
    switch (visit.status.toLowerCase()) {
      case "completed":
        return Icons.check_circle;

      case "assigned":
        return Icons.person;

      case "pending":
        return Icons.schedule;

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
                    radius: 22,
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
                          visit.serviceName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          visit.amcId,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Chip(
                    backgroundColor:
                    statusColor.withOpacity(.12),
                    label: Text(
                      visit.status.toUpperCase(),
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const Divider(height: 28),

              _infoRow(
                Icons.phone,
                "Customer",
                visit.userPhone,
              ),

              _infoRow(
                Icons.person,
                "Partner",
                visit.partnerName ?? "Not Assigned",
              ),

              _infoRow(
                Icons.calendar_today,
                "Visit Date",
                visit.scheduledDate.split("T").first,
              ),

              _infoRow(
                Icons.access_time,
                "Time Slot",
                visit.timeSlot,
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
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

  Widget _infoRow(
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
            width: 95,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
            ),
          ),

        ],
      ),
    );
  }
}