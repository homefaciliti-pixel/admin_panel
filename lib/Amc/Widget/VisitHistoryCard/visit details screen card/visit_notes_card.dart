import 'package:flutter/material.dart';
import '../../../Amc_Model/amc_dashboard/today_visit_model.dart';



class VisitNotesCard extends StatelessWidget {
  final VisitModel visit;

  const VisitNotesCard({
    super.key,
    required this.visit,
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

            const Row(
              children: [

                Icon(
                  Icons.notes,
                  color: Colors.blue,
                ),

                SizedBox(width: 10),

                Text(
                  "Visit Notes",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),

            const Divider(height: 25),

            /// Partner Notes
            const Text(
              "Partner Notes",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 8),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                (visit.notes ?? "").isEmpty
                    ? "No notes available."
                    : visit.notes!,
              ),
            ),

            const SizedBox(height: 20),

            /// Customer Feedback
            const Text(
              "Customer Feedback",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 8),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                (visit.customerFeedback ?? "").isEmpty
                    ? "No customer feedback."
                    : visit.customerFeedback!,
              ),
            ),

            if (visit.rating > 0) ...[

              const SizedBox(height: 18),

              Row(
                children: [

                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),

                  const SizedBox(width: 8),

                  Text(
                    "${visit.rating}/5",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),

            ],

          ],
        ),
      ),
    );
  }
}