import 'package:flutter/material.dart';

import '../../Amc_Model/active_amc_model.dart';

class AdminNotesCard extends StatelessWidget {
  final ActiveAmcModel amc;

  const AdminNotesCard({
    super.key,
    required this.amc,
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

            const Text(
              "Admin Notes",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Divider(),

            noteTile(
              Icons.info_outline,
              "Customer prefers evening visits only.",
            ),

            noteTile(
              Icons.phone,
              "Call customer before reaching location.",
            ),

            noteTile(
              Icons.security,
              "Carry ID card during every visit.",
            ),

            noteTile(
              Icons.warning_amber,
              "Gate pass required for entry.",
            ),

          ],
        ),
      ),
    );
  }

  Widget noteTile(
      IconData icon,
      String text,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Icon(
            icon,
            color: Colors.orange,
          ),

          const SizedBox(width: 12),

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
}