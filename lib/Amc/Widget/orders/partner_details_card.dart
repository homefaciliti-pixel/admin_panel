import 'package:flutter/material.dart';

class PartnerDetailsCard extends StatelessWidget {
  final String partnerName;
  final String phone;
  final double rating;
  final String status;
  final String partnerPhone;
  final double partnerRating;
  final String partnerStatus;

  final VoidCallback? onChangePartner;
  final VoidCallback? onCallPartner;

  const PartnerDetailsCard({
    super.key,
    required this.partnerName,
    String? phone,
    double? rating,
    String? status,
    this.onChangePartner,
    this.onCallPartner,
    required this.partnerPhone,
    required this.partnerRating,
    required this.partnerStatus,
  }) : phone = phone ?? partnerPhone,
       rating = rating ?? partnerRating,
       status = status ?? partnerStatus;

  Color get statusColor {
    switch (status) {
      case "Available":
        return Colors.green;

      case "Busy":
        return Colors.orange;

      case "Offline":
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.engineering, color: Colors.blue),

                SizedBox(width: 10),

                Text(
                  "Assigned Partner",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const Divider(height: 25),

            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue.shade100,
                  child: const Icon(Icons.person, size: 30, color: Colors.blue),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        partnerName,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(phone),

                      const SizedBox(height: 5),

                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),

                          const SizedBox(width: 5),

                          Text(rating.toString()),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(.15),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                FilledButton.icon(
                  onPressed: onCallPartner,
                  icon: const Icon(Icons.call),
                  label: const Text("Call"),
                ),

                OutlinedButton.icon(
                  onPressed: onChangePartner,
                  icon: const Icon(Icons.swap_horiz),
                  label: const Text("Change Partner"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
