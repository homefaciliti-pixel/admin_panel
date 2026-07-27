import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../AMC_ViewModel/book_service/book_service_viewmodel.dart';
import '../common resuse/app_dropdown.dart';
import '../common resuse/app_section_title.dart';

class ServiceSelectionCard extends StatelessWidget {
  const ServiceSelectionCard({super.key});

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
                  title: "Select Service",
                ),

                const SizedBox(height: 20),

                AppDropdown(
                  value: vm.selectedService,
                  hint: "Choose Service",
                  items: const [
                    "Fan Repair",
                    "MCB Repair",
                    "Wiring",
                    "Switch Board",
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      vm.selectService(value);
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