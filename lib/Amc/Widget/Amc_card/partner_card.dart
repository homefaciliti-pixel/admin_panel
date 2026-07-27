import 'package:flutter/material.dart';

import '../../Amc_Model/active_amc_model.dart';

class PartnerCard extends StatelessWidget {
  final ActiveAmcModel amc;
  const PartnerCard({super.key,required this.amc,});

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
              radius: 28,
              backgroundColor: Colors.green.shade100,
              child: const Icon(
                Icons.engineering,
                color: Colors.green,
              ),
            ),

            const SizedBox(width: 15),

            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "Rahul Sharma",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  SizedBox(height: 5),

                  Text("9876543210"),

                  Text("Verified Partner ⭐"),

                ],
              ),
            ),

            FilledButton(
              onPressed: () {},
              child: const Text("View"),
            )

          ],
        ),
      ),
    );
  }
}