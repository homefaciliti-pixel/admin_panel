import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../AMC_ViewModel/book_service/book_service_viewmodel.dart';
import '../common resuse/app_dropdown.dart';
import '../common resuse/app_section_title.dart';

class PartnerSelectionCard extends StatelessWidget {
  const PartnerSelectionCard({super.key});

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
                  title: "Assign Partner",
                ),

                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: vm.autoAssign,
                  title: const Text("Auto Assign Partner"),
                  subtitle: const Text(
                    "Nearest available partner will be assigned",
                  ),
                  onChanged: vm.changeAutoAssign,
                ),

                if (!vm.autoAssign) ...[

                  const SizedBox(height: 15),

                  AppDropdown(
                    value: vm.selectedPartner,
                    hint: "Select Partner",
                    items: const [
                      "Rahul Sharma",
                      "Mohit Kumar",
                      "Aman Verma",
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        vm.selectPartner(value);
                      }
                    },
                  ),
                ],

                if (!vm.autoAssign && vm.selectedPartner != null) ...[

                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.green.shade100,
                      ),
                    ),
                    child: Row(
                      children: [

                        const CircleAvatar(
                          radius: 24,
                          child: Icon(Icons.person),
                        ),

                        const SizedBox(width: 15),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [

                              Text(
                                vm.selectedPartner!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),

                              const SizedBox(height: 5),

                              const Text("⭐ Rating : 4.8"),

                              const Text("📍 Distance : 1.2 KM"),

                              const Text(
                                "🟢 Available",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}