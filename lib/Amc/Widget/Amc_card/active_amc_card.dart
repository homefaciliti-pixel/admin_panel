import 'package:flutter/material.dart';
import '../../Amc_Model/active_amc_model.dart';

class ActiveAmcCard extends StatelessWidget {
  final ActiveAmcModel amc;

  final VoidCallback? onView;
  final VoidCallback? onBookService;
  final VoidCallback? onHistory;
  final VoidCallback? onRenew;
  final bool isExpired;
  const ActiveAmcCard({
    super.key,
    required this.amc,
    this.onView,
    this.onBookService,
    this.onHistory,
    this.onRenew,
    this.isExpired = false,
  });



  @override
  Widget build(BuildContext context) {
    final progress = isExpired
        ? 1.0
        : amc.completedVisits / amc.totalVisits;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 18),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        amc.customerName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 3),

                      Text(
                        "AMC ID : ${amc.amcId}",
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: isExpired
                        ? Colors.red.shade100
                        : Colors.green.shade100,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    isExpired ? "EXPIRED" : "ACTIVE",
                    style: TextStyle(
                      color: isExpired ? Colors.red : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )

              ],
            ),

            const SizedBox(height: 20),

            Wrap(
              spacing: 35,
              runSpacing: 18,
              children: [

                info(Icons.phone, "Phone", amc.customerPhone),

                info(Icons.category, "Category", amc.category),

                info(
                  Icons.person_pin,
                  "Partner",
                  amc.assignedPartner.isEmpty ? "Pending" : amc.assignedPartner,
                ),

                info(Icons.location_on, "Address", amc.address),

                info(
                  Icons.currency_rupee,
                  "Amount",
                    "₹${amc.price.toStringAsFixed(0)}"
                ),

                info(Icons.calendar_today, "Expiry", amc.endDate),

              ],
            ),

            const SizedBox(height: 25),

            Row(
              children: [

                const Icon(
                  Icons.analytics,
                  color: Colors.blue,
                ),

                const SizedBox(width: 8),

                Text(
                  "${amc.completedVisits}/${amc.totalVisits} Services Completed",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 10),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              isExpired
                  ? "AMC Expired on ${amc.endDate}"
                  : "${amc.totalVisits - amc.completedVisits} Visits Remaining",
              style: TextStyle(
                color: isExpired ? Colors.red : Colors.grey,
                fontWeight: isExpired ? FontWeight.w600 : FontWeight.normal,
              ),
            ),

            const SizedBox(height: 25),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [

                FilledButton.icon(
                  onPressed: onView,
                  icon: const Icon(Icons.visibility),
                  label: const Text("View Details"),
                ),

                if (!isExpired)
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: onBookService,
                    icon: const Icon(Icons.build),
                    label: const Text("Book Service"),
                  ),

                if (!isExpired)
                  OutlinedButton.icon(
                    onPressed: onHistory,
                    icon: const Icon(Icons.history),
                    label: const Text("History"),
                  ),

                if (isExpired)
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    onPressed: onRenew,
                    icon: const Icon(Icons.refresh),
                    label: const Text("Renew AMC"),
                  ),

              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget info(
      IconData icon,
      String title,
      String value,
      ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [

        Icon(
          icon,
          color: Colors.blue,
          size: 18,
        ),

        const SizedBox(width: 6),

        Text(
          "$title : ",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(value),

      ],
    );
  }
}