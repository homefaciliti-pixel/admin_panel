import 'package:flutter/material.dart';

class AppStatusChip extends StatelessWidget {
  final String status;

  const AppStatusChip({
    super.key,
    required this.status,
  });

  Color get color {
    switch (status.toLowerCase()) {
      case "active":
      case "completed":
        return Colors.green;

      case "pending":
      case "upcoming":
        return Colors.orange;

      case "cancelled":
      case "expired":
        return Colors.red;

      case "assigned":
      case "in progress":
        return Colors.blue;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: color.withOpacity(.12),
      side: BorderSide(color: color.withOpacity(.25)),
      label: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}