import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../AMC_ViewModel/book_service/book_service_viewmodel.dart';
import '../../Amc_Model/active_amc_model.dart';
import '../../Widget/book_service/amc_status_card.dart';
import '../../Widget/book_service/customer_info_card.dart';
import '../../Widget/book_service/service_selection_card.dart';
import '../../Widget/book_service/schedule_card.dart';
import '../../Widget/book_service/partner_selection_card.dart';
import '../../Widget/book_service/special_instruction_card.dart';
import '../../Widget/book_service/booking_summary_card.dart';
class BookServiceScreen extends StatelessWidget {

  final ActiveAmcModel amc;

  const BookServiceScreen({
    super.key,
    required this.amc,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(elevation: 0, title: const Text("Book AMC Service")),

      body: Consumer<BookServiceViewModel>(
        builder: (context, vm, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Customer
                CustomerInfoCard(
                  amc: amc,
                ),

                const SizedBox(height: 20),

                /// AMC Status
                AmcStatusCard(
                  amc: amc,
                ),

                const SizedBox(height: 20),

                /// Service
                const ServiceSelectionCard(),

                /// Schedule
                const ScheduleCard(),

                const SizedBox(height: 20),

                /// Partner
                const PartnerSelectionCard(),

                const SizedBox(height: 20),

                /// Instruction
                const SpecialInstructionCard(),

                const SizedBox(height: 20),

                /// Summary
                const BookingSummaryCard(),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: FilledButton.icon(
                    icon: vm.loading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.check_circle),

                    label: Text(
                      vm.loading ? "Creating Booking..." : "Create Booking",
                    ),

                    onPressed: vm.loading
                        ? null
                        : () async {
                            final success = await vm.createBooking();

                            if (!context.mounted) return;

                            if (!success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Please fill all required fields",
                                  ),
                                ),
                              );

                              return;
                            }

                            showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),

                                  title: const Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      ),

                                      SizedBox(width: 10),

                                      Text("Booking Created"),
                                    ],
                                  ),

                                  content: const Text(
                                    "AMC Service Booking created successfully.",
                                  ),

                                  actions: [
                                    FilledButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      child: const Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                  ),
                ),

                const SizedBox(height: 20),


              ],
            ),
          );
        },
      ),
    );
  }
}
