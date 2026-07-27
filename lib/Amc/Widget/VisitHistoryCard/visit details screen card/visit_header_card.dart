import 'package:flutter/material.dart';
import '../../../Amc_Model/amc_dashboard/today_visit_model.dart';



class VisitHeaderCard extends StatelessWidget {
  final VisitModel visit;

  const VisitHeaderCard({
    super.key,
    required this.visit,
  });

  Color get statusColor {
    switch (visit.status) {
      case "Completed":
        return Colors.green;

      case "Pending":
        return Colors.orange;

      case "Cancelled":
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  IconData get statusIcon {
    switch (visit.status) {
      case "Completed":
        return Icons.check_circle;

      case "Pending":
        return Icons.schedule;

      case "Cancelled":
        return Icons.cancel;

      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [

            CircleAvatar(
              radius: 34,
              backgroundColor: statusColor.withOpacity(.15),
              child: Icon(
                statusIcon,
                color: statusColor,
                size: 34,
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "Visit #${visit.visitNumber}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    visit.serviceName,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [

                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.grey,
                      ),

                      const SizedBox(width: 6),

                      Text(visit.visitDate),

                      const SizedBox(width: 20),

                      const Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey,
                      ),

                      const SizedBox(width: 6),

                      Text(visit.visitTime),

                    ],
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(.15),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                visit.status,
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