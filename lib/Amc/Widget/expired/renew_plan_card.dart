import 'package:flutter/material.dart';
import '../../Amc_Model/active_amc_model.dart';

class RenewPlanCard extends StatelessWidget {
  final ActiveAmcModel amc;

  const RenewPlanCard({
    super.key,
    required this.amc,
  });

  Widget feature(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.orange.shade100,
                  child: const Icon(
                    Icons.workspace_premium,
                    color: Colors.orange,
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        amc.planName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      const Text(
                        "365 Days Validity",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        amc.category,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),

                    ],
                  ),
                ),

                Text(
                  "₹${amc.price.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 20),

            feature("${amc.totalVisits} Free Service Visits"),
            feature("Priority Customer Support"),
            feature("Verified Expert Partners"),
            feature("Free Inspection"),
            feature("Instant Booking"),
            feature("No Hidden Charges"),

          ],
        ),
      ),
    );
  }
}