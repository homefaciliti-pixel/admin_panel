import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../service_Api/Dashboard/dashboard_auth.dart';
import '../../widgets/common/stat_card.dart';
import 'radar_map_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key, });

  //final String token;

  int getGrid(double width) {
    if (width > 1400) return 4;
    if (width > 1000) return 3;
    if (width > 700) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardViewModel()..fetchDashboard(),
      child: Consumer<DashboardViewModel>(
        builder: (context, vm, child) {
          final width = MediaQuery.of(context).size.width;

          if (vm.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (vm.errorMessage != null) {
            return Center(
              child: Text(
                vm.errorMessage!,
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Dashboard Overview",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                GridView.count(
                  crossAxisCount: getGrid(width),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  childAspectRatio: 2.4,
                  children: [
                    StatCard(
                      title: "Total Users",
                      value: "${vm.totalUsers}",
                      icon: Icons.people,
                      onTap: () {
                        Navigator.pushNamed(context, "/users");
                      },
                    ),
                    StatCard(
                      title: "Total Categories",
                      value: "${vm.totalCategories}",
                      icon: Icons.category,
                      onTap: () {
                        Navigator.pushNamed(context, "/categories");
                      },
                    ),
                    StatCard(
                      title: "Total Services",
                      value: "${vm.totalServices}",
                      icon: Icons.miscellaneous_services,
                      onTap: () {
                        Navigator.pushNamed(context, "/services");
                      },
                    ),
                    StatCard(
                      title: "Total Partners",
                      value: "${vm.totalPartners}",
                      icon: Icons.person,
                      onTap: () {
                        Navigator.pushNamed(context, "/partners");
                      },
                    ),
                    StatCard(
                      title: "Active Partners",
                      value: "${vm.activePartners}",
                      icon: Icons.online_prediction,
                      onTap: () {
                        Navigator.pushNamed(context, "/partners");
                      },
                    ),
                    StatCard(
                      title: "Total Orders",
                      value: "${vm.totalOrders}",
                      icon: Icons.shopping_cart,
                      onTap: () {
                        Navigator.pushNamed(context, "/orders");
                      },
                    ),
                    StatCard(
                      title: "Today Orders",
                      value: "${vm.todayOrders}",
                      icon: Icons.today,
                      onTap: () {
                        Navigator.pushNamed(context, "/orders");
                      },
                    ),
                    StatCard(
                      title: "Subscription Earning",
                      value: vm.subscriptionEarning,
                      icon: Icons.workspace_premium,
                      onTap: () {
                        Navigator.pushNamed(context, "/reports");
                      },
                    ),
                    StatCard(
                      title: "Order Earning",
                      value: vm.orderEarning,
                      icon: Icons.currency_rupee,
                      onTap: () {
                        Navigator.pushNamed(context, "/reports");
                      },
                    ),
                    StatCard(
                      title: "Complete Orders",
                      value: "${vm.completeOrders}",
                      icon: Icons.check_circle,
                      onTap: () {
                        Navigator.pushNamed(context, "/orders");
                      },
                    ),
                    StatCard(
                      title: "Assigned Orders",
                      value: "${vm.assignedOrders}",
                      icon: Icons.assignment_ind,
                      onTap: () {
                        Navigator.pushNamed(context, "/orders");
                      },
                    ),
                    StatCard(
                      title: "Cancel Orders",
                      value: "${vm.cancelOrders}",
                      icon: Icons.cancel,
                      onTap: () {
                        Navigator.pushNamed(context, "/orders");
                      },
                    ),
                    StatCard(
                      title: "Total Supporters",
                      value: "${vm.totalSupporters}",
                      icon: Icons.support_agent,
                      onTap: () {
                        Navigator.pushNamed(context, "/support");
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  "Active Partners Location Map",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                RadarMapWidget(activePartners: vm.activePartnersList),
              ],
            ),
          );
        },
      ),
    );
  }
}