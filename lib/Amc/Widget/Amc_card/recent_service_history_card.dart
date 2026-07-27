import 'package:flutter/material.dart';

class RecentServiceHistoryCard extends StatelessWidget {

  final String amcId;

  const RecentServiceHistoryCard({
    super.key,
    required this.amcId,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                const Text(
                  "Recent Service History",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                TextButton(
                  onPressed: () {},
                  child: const Text("View All"),
                ),

              ],
            ),

            const Divider(),

            historyTile(
              Icons.check_circle,
              Colors.green,
              "Visit #1",
              "Electrical Inspection",
              "15 Jul 2026",
              "Completed",
            ),

            historyTile(
              Icons.check_circle,
              Colors.green,
              "Visit #2",
              "Fan Repair",
              "28 Jul 2026",
              "Completed",
            ),

            historyTile(
              Icons.schedule,
              Colors.orange,
              "Visit #3",
              "MCB Checking",
              "10 Aug 2026",
              "Upcoming",
            ),

          ],
        ),
      ),
    );
  }

  Widget historyTile(
      IconData icon,
      Color color,
      String title,
      String service,
      String date,
      String status,
      ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(.12),
        child: Icon(icon, color: color),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text("$service\n$date"),
      trailing: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: color.withOpacity(.12),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          status,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}