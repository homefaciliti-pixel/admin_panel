import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppDatePickerField extends StatelessWidget {
  final DateTime? selectedDate;
  final VoidCallback onTap;

  const AppDatePickerField({
    super.key,
    required this.selectedDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: IgnorePointer(
        child: TextFormField(
          controller: TextEditingController(
            text: selectedDate == null
                ? ""
                : DateFormat("dd MMM yyyy").format(selectedDate!),
          ),
          decoration: InputDecoration(
            hintText: "Select Date",
            prefixIcon: const Icon(Icons.calendar_today),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}