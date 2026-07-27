import 'package:admin_panel/Amc/view/visitHistoryScreen/visit_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../AMC_ViewModel/dashboard_viewmodel/today_visit_viewmodel.dart';
 import '../../Widget/VisitHistoryCard/visit_history_card.dart';
import '../../Widget/common resuse/aap_empty_view.dart';
import '../../Widget/common resuse/app_loading_view.dart';
import '../../Widget/common resuse/app_search_field.dart';


class VisitHistoryScreen extends StatefulWidget {
  const VisitHistoryScreen({super.key});

  @override
  State<VisitHistoryScreen> createState() =>
      _VisitHistoryScreenState();
}

class _VisitHistoryScreenState
    extends State<VisitHistoryScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VisitViewModel>().fetchVisits();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        title: const Text("Visit History"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              "Visit History",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Manage all AMC visit records",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            AppSearchField(
              hint: "Search Visit / Partner / Service",
              onChanged: (value) {
                context
                    .read<VisitViewModel>()
                    .search(value);
              },
            ),

            const SizedBox(height: 20),

            Consumer<VisitViewModel>(
              builder: (context, vm, child) {

                return Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [

                    _chip(vm, "All"),

                    _chip(vm, "Completed"),

                    _chip(vm, "Pending"),

                    _chip(vm, "Cancelled"),

                  ],
                );
              },
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Consumer<VisitViewModel>(
                builder: (context, vm, child) {

                  if (vm.loading) {
                    return const AppLoadingView();
                  }

                  if (vm.filteredList.isEmpty) {
                    return const AppEmptyView(
                      title: "No Visit History Found",
                      icon: Icons.history_toggle_off,
                    );
                  }

                  return RefreshIndicator(

                    onRefresh: vm.refresh,

                    child: ListView.builder(

                      itemCount: vm.filteredList.length,

                      itemBuilder: (context, index) {
                        final visit = vm.filteredList[index];

                        return VisitCard(
                          visit: visit,

                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => VisitDetailsScreen(
                                  visit: visit,
                                ),
                              ),
                            );
                          },



                        );
                      },
                    ),
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _chip(
      VisitViewModel vm,
      String status,
      ) {
    return FilterChip(

      label: Text(status),

      selected: vm.selectedStatus == status,

      onSelected: (_) {
        vm.changeStatus(status);
      },

    );
  }
}