import 'package:flutter/material.dart';

class AdminAmcCard extends StatelessWidget {
  final String amcId;
  final String customerName;
  final String phone;
  final String category;
  final double amount;
  final String status;
  final String startDate;
  final String endDate;
  final VoidCallback onView;

  const AdminAmcCard({
    super.key,
    required this.amcId,
    required this.customerName,
    required this.phone,
    required this.category,
    required this.amount,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    bool isActive = status.toLowerCase() == "active";

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.15),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.workspace_premium, color: Colors.green),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  amcId,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: isActive ? Colors.green.shade100 : Colors.red.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: isActive ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          _row(Icons.person, customerName),

          _row(Icons.phone, phone),

          _row(Icons.miscellaneous_services, category),

          _row(Icons.currency_rupee, amount.toStringAsFixed(0)),

          _row(Icons.calendar_today, startDate),

          _row(Icons.event, endDate),

          const SizedBox(height: 18),

          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              onPressed: onView,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff1D5A90),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "View Details",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey),

          const SizedBox(width: 10),

          Expanded(child: Text(text, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }
}
