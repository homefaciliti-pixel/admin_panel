import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../AMC_ViewModel/book_service/book_service_viewmodel.dart';
import '../common resuse/app_date_picker_field.dart';
import '../common resuse/app_dropdown.dart';
import '../common resuse/app_section_title.dart';


class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key});

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

                const AppSectionTitle(
                  title: "Schedule",
                ),

                const SizedBox(height: 20),

                AppDatePickerField(
                  selectedDate: vm.selectedDate,
                  onTap: () {
                    vm.pickDate(context);
                  },
                ),

                const SizedBox(height: 20),

                AppDropdown(
                  value: vm.selectedTime,
                  hint: "Select Time Slot",
                  items: const [
                    "Morning",
                    "Afternoon",
                    "Evening",
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      vm.selectTime(value);
                    }
                  },
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}