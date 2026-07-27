import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../AMC_ViewModel/book_service/book_service_viewmodel.dart';

class SpecialInstructionCard extends StatelessWidget {
  const SpecialInstructionCard({super.key});

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
                  "Special Instructions",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: vm.instructionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Write special instructions...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Quick Instructions",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 12),

                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [

                    FilterChip(
                      label: const Text("📞 Call Before Visit"),
                      selected: vm.selectedInstructions.contains("Call Before Visit"),
                      onSelected: (_) {
                        vm.toggleInstruction("Call Before Visit");
                      },
                    ),

                    FilterChip(
                      label: const Text("🪜 Bring Ladder"),
                      selected: false,
                      onSelected: (_) {},
                    ),

                    FilterChip(
                      label: const Text("🔧 Carry Spare Parts"),
                      selected: false,
                      onSelected: (_) {},
                    ),

                    FilterChip(
                      label: const Text("🚪Gate Pass Required"),
                      selected: false,
                      onSelected: (_) {},
                    ),

                  ],
                ),

                const SizedBox(height: 25),

                const Text(
                  "Priority",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Wrap(
                  spacing: 10,
                  children: [

                    ChoiceChip(
                      label: const Text("Normal"),
                      selected: vm.priority == "Normal",
                      onSelected: (_) {
                        vm.changePriority("Normal");
                      },
                    ),

                    ChoiceChip(
                      label: const Text("Urgent"),
                      selected: vm.priority == "Urgent",
                      onSelected: (_) {
                        vm.changePriority("Urgent");
                      },
                    ),

                    ChoiceChip(
                      label: const Text("Emergency"),
                      selected: vm.priority == "Emergency",
                      onSelected: (_) {
                        vm.changePriority("Emergency");
                      },
                    ),

                  ],
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}