import 'package:flutter/material.dart';

import '../../Amc_Model/active_amc_model.dart';

class PropertyDetailsCard extends StatelessWidget {
  final ActiveAmcModel amc;

  const PropertyDetailsCard({super.key,required this.amc});


  Widget infoTile(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [

          Icon(icon, color: Colors.blue),

          const SizedBox(width: 12),

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

            const Text(
              "🏠 Property Details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Divider(),

            infoTile(Icons.category, "Category", "Electrical"),

            infoTile(Icons.square_foot, "Area", "2400 Sq Ft"),

            infoTile(Icons.layers, "Floors", "2"),

            infoTile(Icons.home_work, "House Type", "Villa"),

            const SizedBox(height: 15),

            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                height: 220,
                width: double.infinity,
                color: Colors.grey.shade200,
                child: const Center(
                  child: Icon(
                    Icons.image,
                    size: 70,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}