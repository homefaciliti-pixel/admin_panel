import 'package:flutter/material.dart';

 import '../../../Amc_Model/amc_dashboard/today_visit_model.dart';



class VisitPartnerCard extends StatelessWidget {
  final VisitModel visit;

  const VisitPartnerCard({
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
                  Icons.engineering,
                  color: Colors.blue,
                ),

                SizedBox(width: 10),

                Text(
                  "Partner Details",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),

            const Divider(height: 25),

            Row(
              children: [

                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.blue.shade100,
                  child: const Icon(
                    Icons.person,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      Text(
                        visit.partnerName ?? "Not Assigned",
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        (visit.partnerPhone ?? "").isEmpty
                            ? "No Phone"
                            : visit.partnerPhone!,
                      ),

                      const SizedBox(height: 3),

                      Text(
                        (visit.partnerEmail ?? "").isEmpty
                            ? "No Email"
                            : visit.partnerEmail!,
                      ),

                      const SizedBox(height: 3),

                      Text(
                        "Partner ID : ${visit.partnerId}",
                      ),

                    ],
                  ),
                ),

              ],
            ),

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.icon(
                onPressed: () {
                  // TODO Call Partner
                },
                icon: const Icon(Icons.call),
                label: const Text("Call"),
              ),
            ),

          ],
        ),
      ),
    );
  }
}