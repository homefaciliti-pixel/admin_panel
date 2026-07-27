import 'package:flutter/material.dart';
import '../../Amc_Model/active_amc_model.dart';

class AmcStatusCard extends StatelessWidget {
  final ActiveAmcModel amc;

  const AmcStatusCard({
    super.key,
    required this.amc,
  });

  Widget item(
      IconData icon,
      String title,
      String value,
      Color color,
      ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withOpacity(.08),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "AMC Status",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 18),

            Row(
              children: [

                item(
                  Icons.verified,
                  "Status",
                  "Active",
                  Colors.green,
                ),

                const SizedBox(width: 12),

                item(
                  Icons.repeat,
                  "Visits Left",
                  "10",
                  Colors.orange,
                ),

              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [

                item(
                  Icons.workspace_premium,
                  "Plan",
                  "Premium",
                  Colors.blue,
                ),

                const SizedBox(width: 12),

                item(
                  Icons.event,
                  "Expiry",
                  amc.endDate,
                  Colors.red,
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}