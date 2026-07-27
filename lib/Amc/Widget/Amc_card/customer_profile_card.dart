import 'package:flutter/material.dart';
import '../../Amc_Model/active_amc_model.dart';

class CustomerProfileCard extends StatelessWidget {
  final ActiveAmcModel amc;

  final bool isExpired;

  const CustomerProfileCard({
    super.key,
    required this.amc,
    this.isExpired = false,
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
        child: Row(
          children: [

            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.blue.shade100,
              child: const Icon(
                Icons.person,
                size: 38,
                color: Colors.blue,
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    amc.customerName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text("AMC ID : ${amc.amcId}"),

                  Text(amc.customerPhone),

                  Text(amc.address),

                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 8,
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
                  color: isExpired
                      ? Colors.red
                      : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}