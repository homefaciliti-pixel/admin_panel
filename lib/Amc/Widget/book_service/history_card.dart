import 'package:flutter/material.dart';
import '../../Amc_Model/service_history_model.dart';
import '../common resuse/app_status_chip.dart';

class HistoryCard extends StatelessWidget {
  final ServiceHistoryModel history;

  const HistoryCard({
    super.key,
    required this.history,
  });

  Color get statusColor {
    switch (history.status) {
      case "Completed":
        return Colors.green;
      case "Upcoming":
        return Colors.orange;
      case "Cancelled":
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  IconData get statusIcon {
    switch (history.status) {
      case "Completed":
        return Icons.check_circle;
      case "Upcoming":
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
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Header
            Row(
              children: [

                CircleAvatar(
                  backgroundColor: statusColor.withOpacity(.15),
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
                        history.serviceName,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 3),

                      Text(
                        history.bookingId,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),

                    ],
                  ),
                ),

                const SizedBox(width: 10),

                AppStatusChip(
                  status: history.status,
                ),

              ],
            ),

            const Divider(height: 30),

            _row(Icons.person, "Partner", history.partnerName),

            _row(Icons.calendar_today, "Visit Date", history.visitDate),

            _row(Icons.access_time, "Visit Time", history.visitTime),

            if (history.notes.isNotEmpty)
              _row(Icons.notes, "Notes", history.notes),

            if (history.rating > 0)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  children: [

                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),

                    const SizedBox(width: 8),

                    Text(
                      "${history.rating}/5",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  ],
                ),
              ),

          ],
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
            width: 100,
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