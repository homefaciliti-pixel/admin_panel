import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../AMC_ViewModel/assign partner viewmodel/assign_partner_viewmodel.dart';
import '../../AMC_ViewModel/orders/amc_view_model.dart';
import '../../Widget/common resuse/aap_empty_view.dart';
import '../../Widget/common resuse/app_loading_view.dart';
import '../../Widget/common resuse/app_search_field.dart';
import '../../Widget/orders/amc_order_card.dart';
import '../../Widget/orders/assign_partner_dialog.dart';
import 'amc_order_details_screen.dart';

class AmcOrdersScreen extends StatefulWidget {
  const AmcOrdersScreen({super.key});

  @override
  State<AmcOrdersScreen> createState() => _AmcOrdersScreenState();
}

class _AmcOrdersScreenState extends State<AmcOrdersScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AmcOrderViewModel>().fetchOrders();
    });
  }

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
              "AMC Orders",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              "Manage all AMC service bookings",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),

            const SizedBox(height: 20),

            AppSearchField(
              hint: "Search Order / Customer / Phone",
              onChanged: (value) {
                context.read<AmcOrderViewModel>().search(value);
              },
            ),

            const SizedBox(height: 20),

            Consumer<AmcOrderViewModel>(
              builder: (context, vm, child) {
                return Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _chip(vm, "All"),

                    _chip(vm, "Pending"),

                    _chip(vm, "Assigned"),

                    _chip(vm, "In Progress"),

                    _chip(vm, "Completed"),

                    _chip(vm, "Cancelled"),
                  ],
                );
              },
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Consumer<AmcOrderViewModel>(
                builder: (context, vm, child) {
                  if (vm.loading) {
                    return const AppLoadingView();
                  }

                  if (vm.filteredList.isEmpty) {
                    return const AppEmptyView(
                      title: "No Orders Found",
                      icon: Icons.assignment_outlined,
                    );
                  }

                  return ListView.builder(
                    itemCount: vm.filteredList.length,

                    itemBuilder: (context, index) {
                      final order = vm.filteredList[index];
                      return AmcOrderCard(
                        order: order,

                        /// View Details
                        onView: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  AmcOrderDetailsScreen(order: order),
                            ),
                          );
                        },

                        /// Assign Partner
                        onAssignPartner: () {
                          showDialog(
                            context: context,
                            builder: (_) => ChangeNotifierProvider(
                              create: (_) => AssignPartnerViewModel(),
                              child: AssignPartnerDialog(order: order),
                            ),
                          );
                        },

                        /// Update Status
                        onUpdateStatus: () {
                          // Abhi next step me dialog banayenge
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

  Widget _chip(AmcOrderViewModel vm, String status) {
    return FilterChip(
      label: Text(status),

      selected: vm.selectedStatus == status,

      onSelected: (_) {
        vm.changeStatus(status);
      },
    );
  }
}
