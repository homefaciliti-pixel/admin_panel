import 'package:flutter/material.dart';

 import '../../../Amc_Model/amc_dashboard/today_visit_model.dart';

 

class VisitServiceCard extends StatelessWidget {
  final VisitModel visit;

  const VisitServiceCard({
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
                  Icons.home_repair_service,
                  color: Colors.blue,
                ),

                SizedBox(width: 10),

                Text(
                  "Service Details",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),

            const Divider(height: 25),

            _infoRow(
              Icons.build,
              "Service",
              visit.serviceName,
            ),

            _infoRow(
              Icons.engineering,
              "Partner",
              visit.partnerName ?? "Not Assigned",
            ),
            _infoRow(
              Icons.calendar_today,
              "Visit Date",
              visit.visitDate,
            ),

            _infoRow(
              Icons.access_time,
              "Visit Time",
              visit.visitTime,
            ),

            if (visit.rating > 0)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [

                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),

                    const SizedBox(width: 8),

                    Text(
                      "${visit.rating} / 5",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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

  Widget _infoRow(
      IconData icon,
      String title,
      String value,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

        ],
      ),
    );
  }
}