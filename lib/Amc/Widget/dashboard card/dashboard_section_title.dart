import 'package:flutter/material.dart';

class DashboardSectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onViewAll;

  const DashboardSectionTitle({
    super.key,
    required this.title,
    required this.icon,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Icon(
          icon,
          color: Colors.blue,
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        if (onViewAll != null)
          TextButton(
            onPressed: onViewAll,
            child: const Text("View All"),
          ),

      ],
    );
  }
}