import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../AMC_ViewModel/book_service/book_service_viewmodel.dart';


class BookingSummaryCard extends StatelessWidget {
  const BookingSummaryCard({super.key});

  Widget row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            value.isEmpty ? "--" : value,
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
    return Consumer<BookServiceViewModel>(
      builder: (context, vm, child) {
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
                  "Booking Summary",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Divider(),

                row(
                  "Selected Service",
                  vm.selectedService ?? "",
                ),

                row(
                  "Partner",
                  vm.autoAssign
                      ? "Auto Assign"
                      : (vm.selectedPartner ?? ""),
                ),

                row(
                  "Booking Date",
                  vm.selectedDate == null
                      ? ""
                      : "${vm.selectedDate!.day}/${vm.selectedDate!.month}/${vm.selectedDate!.year}",
                ),

                row(
                  "Time Slot",
                  vm.selectedTime ?? "",
                ),

                row(
                  "Priority",
                  vm.priority,
                ),

                row(
                  "Remaining Visits",
                  "10",
                ),

                row(
                  "Expected Duration",
                  "1 Hour",
                ),

                row(
                  "Payment",
                  "₹0 (Covered by AMC)",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}