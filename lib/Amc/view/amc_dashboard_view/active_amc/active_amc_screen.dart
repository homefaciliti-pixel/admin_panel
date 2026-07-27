import 'package:admin_panel/Amc/view/admin_amc_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../AMC_ViewModel/dashboard_viewmodel/active_amc_viewmodel.dart';
import '../../../Widget/Amc_card/active_amc_card.dart';

import '../../History/service_history_screen.dart';
import '../../booking/book_service_screen.dart';

class ActiveAmcScreen extends StatelessWidget {
  const ActiveAmcScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Active AMC",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              "Manage all active AMC subscriptions",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 20),

            /// Search
            TextField(
              onChanged: (value) {
                context.read<ActiveAmcViewModel>().search(value);
              },
              decoration: InputDecoration(
                hintText: "Search Customer / AMC ID / Phone",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Category Chips
            Wrap(
              spacing: 10,
              children: [
                Chip(label: Text("All")),
                Chip(label: Text("Electrical")),
                Chip(label: Text("Plumbing")),
                Chip(label: Text("Cleaning")),
                Chip(label: Text("AC")),
              ],
            ),

            const SizedBox(height: 20),

            /// Active AMC List
            Expanded(
              child: Consumer<ActiveAmcViewModel>(
                builder: (context, vm, child) {
                  if (vm.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (vm.filteredList.isEmpty) {
                    return const Center(
                      child: Text(
                        "No Active AMC Found",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: vm.filteredList.length,
                    itemBuilder: (context, index) {
                      final amc = vm.filteredList[index];

                      return ActiveAmcCard(
                        amc: amc,

                        onView: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AdminAmcDetailsView(amc:amc,),
                            ),
                          );
                        },

                        onBookService: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BookServiceScreen(
                                amc: amc,
                              ),
                            ),
                          );
                        },


                        onHistory: () {

                          Navigator.push(

                            context,

                            MaterialPageRoute(

                              builder: (_) => ServiceHistoryScreen(
                                amc: amc,
                              ),

                            ),

                          );

                        },

                        onRenew: () {
                          debugPrint("Renew");
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
