import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../AMC_ViewModel/dashboard_viewmodel/recent_order_viewmodel.dart';
import '../../Widget/amcsimmer/amc_simmer.dart';
import '../../Widget/dashboard card/dashboard_recent_order_card.dart';
import '../../Widget/dashboard card/dashboard_section_title.dart';
import '../../view/Orders/amc_orders_screen.dart';


class DashboardRecentOrders extends StatefulWidget {
  const DashboardRecentOrders({super.key});

  @override
  State<DashboardRecentOrders> createState() =>
      _DashboardRecentOrdersState();
}

class _DashboardRecentOrdersState
    extends State<DashboardRecentOrders> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RecentOrderViewModel>().fetchRecentOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecentOrderViewModel>(
      builder: (context, vm, child) {

        if (vm.loading) {
          return const DashboardAmcShimmer();
        }

        if (vm.error != null) {
          return Center(
            child: Text(vm.error!),
          );
        }

        if (vm.orders.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(40),
              child: Text(
                "No Recent Orders",
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                const Expanded(
                  child: DashboardSectionTitle(
                    title: "Recent Orders",
                    icon: Icons.shopping_bag_outlined,
                  ),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AmcOrdersScreen(),
                      ),
                    );
                  },
                  child: const Text("View All"),
                ),

              ],
            ),

            const SizedBox(height: 20),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: vm.orders.length,
              itemBuilder: (context, index) {

                final order = vm.orders[index];

                return RecentOrderCard(
                  order: order,
                  onTap: () {

                    /// TODO
                    /// Order Detail Screen

                  },
                );
              },
            ),

          ],
        );
      },
    );
  }
}