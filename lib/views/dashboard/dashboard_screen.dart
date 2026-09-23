
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../service_Api/Dashboard/dashboard_auth.dart';
import '../../widgets/common/stat_card.dart';
import '../shimmer/dashboard_shimmer.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  int getGrid(double width) {
    if (width > 1400) return 4;
    if (width > 1000) return 3;
    if (width > 700) return 2;

    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewModel>(
      builder: (
          context,
          vm,
          child,
          ) {
        final width =
            MediaQuery.of(context).size.width;

        // ======================================================
        // LOADING
        // ======================================================

        if (vm.isLoading &&
            vm.dashboardModel == null) {
          return DashboardShimmer(
            crossAxisCount: getGrid(width),
          );
        }

        // ======================================================
        // ERROR
        // ======================================================

        if (vm.errorMessage != null &&
            vm.dashboardModel == null) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 50,
                  color: Colors.red,
                ),

                const SizedBox(height: 12),

                Text(
                  vm.errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),

                const SizedBox(height: 15),

                ElevatedButton(
                  onPressed: () {
                    vm.fetchDashboard();
                  },
                  child: const Text(
                    'Retry',
                  ),
                ),
              ],
            ),
          );
        }

        // ======================================================
        // DASHBOARD
        // ======================================================

        return RefreshIndicator(
          onRefresh: vm.refreshDashboard,
          child: SingleChildScrollView(
            physics:
            const AlwaysScrollableScrollPhysics(),

            padding:
            const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                // ==================================================
                // HEADER
                // ==================================================

                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Dashboard Overview",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),

                    if (vm.isRefreshing)
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child:
                        CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                // ==================================================
                // GRID
                // ==================================================

                GridView.count(
                  crossAxisCount:
                  getGrid(width),

                  shrinkWrap: true,

                  physics:
                  const NeverScrollableScrollPhysics(),

                  crossAxisSpacing: 18,

                  mainAxisSpacing: 18,

                  childAspectRatio: 2.4,

                  children: [
                    // =================================================
                    // USERS
                    // =================================================

                    StatCard(
                      title: "Total Users",
                      value:
                      "${vm.totalUsers}",
                      icon: Icons.people,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/users",
                        );
                      },
                    ),

                    // =================================================
                    // CATEGORIES
                    // =================================================

                    StatCard(
                      title:
                      "Total Categories",
                      value:
                      "${vm.totalCategories}",
                      icon:
                      Icons.category,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/categories",
                        );
                      },
                    ),

                    // =================================================
                    // SERVICES
                    // =================================================

                    StatCard(
                      title:
                      "Total Services",
                      value:
                      "${vm.totalServices}",
                      icon:
                      Icons.miscellaneous_services,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/services",
                        );
                      },
                    ),

                    // =================================================
                    // PARTNERS
                    // =================================================

                    StatCard(
                      title:
                      "Total Partners",
                      value:
                      "${vm.totalPartners}",
                      icon:
                      Icons.person,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/partners",
                        );
                      },
                    ),

                    // =================================================
                    // PENDING
                    // =================================================

                    StatCard(
                      title:
                      "Pending Approval",
                      value:
                      "${vm.pendingApproval}",
                      icon:
                      Icons.pending_actions,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/partners",
                        );
                      },
                    ),

                    // =================================================
                    // ACTIVE PARTNERS
                    // =================================================

                    StatCard(
                      title:
                      "Active Partners",
                      value:
                      "${vm.activePartners}",
                      icon:
                      Icons.online_prediction,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/partners",
                        );
                      },
                    ),

                    // =================================================
                    // ORDERS
                    // =================================================

                    StatCard(
                      title:
                      "Total Orders",
                      value:
                      "${vm.totalOrders}",
                      icon:
                      Icons.shopping_cart,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/orders",
                        );
                      },
                    ),

                    // =================================================
                    // TODAY ORDERS
                    // =================================================

                    StatCard(
                      title:
                      "Today Orders",
                      value:
                      "${vm.todayOrders}",
                      icon: Icons.today,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/orders",
                        );
                      },
                    ),

                    // =================================================
                    // SUBSCRIPTION
                    // =================================================

                    StatCard(
                      title:
                      "Subscription Earning",
                      value:
                      vm.subscriptionEarning,
                      icon:
                      Icons.workspace_premium,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/reports",
                        );
                      },
                    ),

                    // =================================================
                    // ORDER EARNING
                    // =================================================

                    StatCard(
                      title:
                      "Order Earning",
                      value:
                      vm.orderEarning,
                      icon:
                      Icons.currency_rupee,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/reports",
                        );
                      },
                    ),

                    // =================================================
                    // COMPLETE
                    // =================================================

                    StatCard(
                      title:
                      "Complete Orders",
                      value:
                      "${vm.completeOrders}",
                      icon:
                      Icons.check_circle,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/orders",
                        );
                      },
                    ),

                    // =================================================
                    // ASSIGNED
                    // =================================================

                    StatCard(
                      title:
                      "Assigned Orders",
                      value:
                      "${vm.assignedOrders}",
                      icon:
                      Icons.assignment_ind,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/orders",
                        );
                      },
                    ),

                    // =================================================
                    // IN PROGRESS
                    // =================================================

                    StatCard(
                      title:
                      "In Progress Orders",
                      value:
                      "${vm.inProgressOrders}",
                      icon:
                      Icons.hourglass_top,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/orders",
                        );
                      },
                    ),

                    // =================================================
                    // CANCEL
                    // =================================================

                    StatCard(
                      title:
                      "Cancel Orders",
                      value:
                      "${vm.cancelOrders}",
                      icon:
                      Icons.cancel,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/orders",
                        );
                      },
                    ),

                    // =================================================
                    // SUPPORTERS
                    // =================================================

                    StatCard(
                      title:
                      "Total Supporters",
                      value:
                      "${vm.totalSupporters}",
                      icon:
                      Icons.support_agent,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/support",
                        );
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
// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({super.key});
//
//   //final String token;
//
//   int getGrid(double width) {
//     if (width > 1400) return 4;
//     if (width > 1000) return 3;
//     if (width > 700) return 2;
//     return 1;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<DashboardViewModel>(
//       builder: (context, vm, child) {
//         final width = MediaQuery.of(context).size.width;
//
//         if (vm.isLoading) {
//           return const AppLoader();
//           //    text: "Loading Dashboard...",
//         }
//
//         if (vm.errorMessage != null) {
//           return Center(
//             child: Text(
//               vm.errorMessage!,
//               style: const TextStyle(fontSize: 16, color: Colors.red),
//             ),
//           );
//         }
//
//         return SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Dashboard Overview",
//                 style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 20),
//
//               GridView.count(
//                 crossAxisCount: getGrid(width),
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 crossAxisSpacing: 18,
//                 mainAxisSpacing: 18,
//                 childAspectRatio: 2.4,
//                 children: [
//                   StatCard(
//                     title: "Total Users",
//                     value: "${vm.totalUsers}",
//                     icon: Icons.people,
//                     onTap: () {
//                       Navigator.pushNamed(context, "/users");
//                     },
//                   ),
//                   StatCard(
//                     title: "Total Categories",
//                     value: "${vm.totalCategories}",
//                     icon: Icons.category,
//                     onTap: () {
//                       Navigator.pushNamed(context, "/categories");
//                     },
//                   ),
//                   StatCard(
//                     title: "Total Services",
//                     value: "${vm.totalServices}",
//                     icon: Icons.miscellaneous_services,
//                     onTap: () {
//                       Navigator.pushNamed(context, "/services");
//                     },
//                   ),
//                   StatCard(
//                     title: "Total Partners",
//                     value: "${vm.totalPartners}",
//                     icon: Icons.person,
//                     onTap: () {
//                       Navigator.pushNamed(context, "/partners");
//                     },
//                   ),
//
//                   StatCard(
//                     title: "Pending Approval",
//                     value: "${vm.pendingApproval}",
//                     icon: Icons.person,
//                     onTap: () {
//                       Navigator.pushNamed(context, "/partners");
//                     },
//                   ),
//                   StatCard(
//                     title: "Active Partners",
//                     value: "${vm.activePartners}",
//                     icon: Icons.online_prediction,
//                     onTap: () {
//                       Navigator.pushNamed(context, "/partners");
//                     },
//                   ),
//                   StatCard(
//                     title: "Total Orders",
//                     value: "${vm.totalOrders}",
//                     icon: Icons.shopping_cart,
//                     onTap: () {
//                       Navigator.pushNamed(context, "/orders");
//                     },
//                   ),
//                   StatCard(
//                     title: "Today Orders",
//                     value: "${vm.todayOrders}",
//                     icon: Icons.today,
//                     onTap: () {
//                       Navigator.pushNamed(context, "/orders");
//                     },
//                   ),
//                   StatCard(
//                     title: "Subscription Earning",
//                     value: vm.subscriptionEarning,
//                     icon: Icons.workspace_premium,
//                     onTap: () {
//                       Navigator.pushNamed(context, "/reports");
//                     },
//                   ),
//                   StatCard(
//                     title: "Order Earning",
//                     value: vm.orderEarning,
//                     icon: Icons.currency_rupee,
//                     onTap: () {
//                       Navigator.pushNamed(context, "/reports");
//                     },
//                   ),
//                   StatCard(
//                     title: "Complete Orders",
//                     value: "${vm.completeOrders}",
//                     icon: Icons.check_circle,
//                     onTap: () {
//                       Navigator.pushNamed(context, "/orders");
//                     },
//                   ),
//                   StatCard(
//                     title: "Assigned Orders",
//                     value: "${vm.assignedOrders}",
//                     icon: Icons.assignment_ind,
//                     onTap: () {
//                       Navigator.pushNamed(context, "/orders");
//                     },
//                   ),
//                   StatCard(
//                     title: "Cancel Orders",
//                     value: "${vm.cancelOrders}",
//                     icon: Icons.cancel,
//                     onTap: () {
//                       Navigator.pushNamed(context, "/orders");
//                     },
//                   ),
//                   StatCard(
//                     title: "Total Supporters",
//                     value: "${vm.totalSupporters}",
//                     icon: Icons.support_agent,
//                     onTap: () {
//                       Navigator.pushNamed(context, "/support");
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
