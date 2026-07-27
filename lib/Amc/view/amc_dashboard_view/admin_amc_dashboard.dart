import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../service_Api/Dashboard/dashboard_auth.dart';
import '../../AMC_ViewModel/dashboard_viewmodel/admin_amc_dashboard_viewmodel.dart';
import '../../Widget/amcsimmer/amc_simmer.dart';
import '../../Widget/dashboard card/dashboard_amc_overview.dart';
import '../../Widget/dashboard card/dashboard_header.dart';
import '../../Widget/dashboard card/dashboard_operations_section.dart';
import '../../Widget/dashboard card/dashboard_payment_section.dart';
import '../../Widget/dashboard card/dashboard_quick_actions_section.dart';

import '../Orders/amc_orders_screen.dart';
import '../Partner payment/partner_payment_screen.dart';
import '../amc_dashboard_view/active_amc/active_amc_screen.dart';
import '../expired/expired_amc_screen.dart';
import '../visitHistoryScreen/visit_history_screen.dart';
import 'dashboard_recent_orders.dart';

class AdminAmcDashboard extends StatefulWidget {
  const AdminAmcDashboard({super.key});

  @override
  State<AdminAmcDashboard> createState() => _AdminAmcDashboardState();
}

class _AdminAmcDashboardState extends State<AdminAmcDashboard> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardAmcViewModel>().fetchDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardAmcViewModel>(
      builder: (context, vm, child) {

        /// Loading
        if (vm.loading) {
          return const Scaffold(
            backgroundColor: Color(0xffF5F7FA),
            body: DashboardAmcShimmer(),
          );
        }

        /// Error
        if (vm.error != null) {
          return Scaffold(
            backgroundColor: const Color(0xffF5F7FA),
            body: Center(
              child: Text(
                vm.error!,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ),
          );
        }

        /// No Data
        if (vm.dashboard == null) {
          return const Scaffold(
            backgroundColor: Color(0xffF5F7FA),
            body: Center(
              child: Text(
                "No Dashboard Data",
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: const Color(0xffF5F7FA),

          body: RefreshIndicator(
            onRefresh: () async {
              await vm.fetchDashboard();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const DashboardHeader(),

                  const SizedBox(height: 30),

                  DashboardAmcOverview(
                    dashboard: vm.dashboard!,
                  ),

                  const SizedBox(height: 30),

                  DashboardOperationsSection(
                    dashboard: vm.dashboard!,
                  ),

                  const SizedBox(height: 30),

                  DashboardPaymentSection(
                    dashboard: vm.dashboard!,
                  ),

                  const SizedBox(height: 30),

                  DashboardQuickActionsSection(

                    onActiveAmc: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ActiveAmcScreen(),
                        ),
                      );
                    },

                    onOrders: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AmcOrdersScreen(),
                        ),
                      );
                    },

                    onVisits: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const VisitHistoryScreen(),
                        ),
                      );
                    },

                    onPayments: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PartnerPaymentScreen(),
                        ),
                      );
                    },

                    onExpiredAmc: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ExpiredAmcScreen(),
                        ),
                      );
                    },


                  ),

                  const SizedBox(height: 30),
                  const DashboardRecentOrders(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}