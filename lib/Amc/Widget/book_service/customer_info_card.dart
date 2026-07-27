import 'package:admin_panel/Amc/Amc_Model/active_amc_model.dart';
import 'package:flutter/material.dart';

import '../common resuse/app_info_row.dart';
import '../common resuse/app_section_title.dart';

class CustomerInfoCard extends StatelessWidget {

  final ActiveAmcModel amc;

  final String title;
  final bool showStatus;

  const CustomerInfoCard({
    super.key,
    required this.amc,
    this.title = "Customer Information",
    this.showStatus = false,
  });

  Widget infoRow(
      IconData icon,
      String title,
      String value,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [

          Icon(
            icon,
            size: 18,
            color: Colors.blue,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
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
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Row(
              children: [

                Icon(
                  Icons.person,
                  color: Colors.blue,
                ),

                SizedBox(width: 8),

                AppSectionTitle(
                  title: "Customer Information",
                ),

              ],
            ),

            const Divider(),

            AppInfoRow(
              icon: Icons.person,
              title: "Customer",
              value: amc.customerName,
            ),
            AppInfoRow(
              icon: Icons.phone,
              title: "Phone",
              value: amc.customerPhone,
            ),

            AppInfoRow(
              icon: Icons.confirmation_number,
              title: "AMC ID",
              value: amc.amcId,
            ),

            AppInfoRow(
              icon: Icons.category,
              title: "Category",
              value: amc.category,
            ),

            AppInfoRow(
              icon: Icons.location_on,
              title: "Address",
              value: amc.address,
            ),

          ],
        ),
      ),
    );
  }
}