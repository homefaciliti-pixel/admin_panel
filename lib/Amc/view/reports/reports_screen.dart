import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../AMC_ViewModel/reports/report_viewmodel.dart';
import '../../Widget/common resuse/app_loading_view.dart';
import '../../Widget/reports/report_summary_card.dart';

class AmcReportsScreen extends StatefulWidget {
  const AmcReportsScreen({super.key});

  @override
  State<AmcReportsScreen> createState() =>
      _AmcReportsScreenState();
}

class _AmcReportsScreenState
    extends State<AmcReportsScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AmcReportViewModel>().fetchReport();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF5F7FA),

      body: Consumer<AmcReportViewModel>(
        builder: (context, vm, child) {

          if (vm.loading) {
            return const AppLoadingView();
          }

          if (vm.error != null) {
            return Center(
              child: Text(vm.error!),
            );
          }

          final report = vm.report;

          if (report == null) {
            return const Center(
              child: Text("No Report Found"),
            );
          }

          return RefreshIndicator(

            onRefresh: vm.refresh,

            child: SingleChildScrollView(

              physics:
              const AlwaysScrollableScrollPhysics(),

              padding: const EdgeInsets.all(20),

              child: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  const Text(
                    "AMC Reports",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Overview of subscriptions, revenue & payouts",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 25),

                  GridView.count(

                    shrinkWrap: true,

                    physics:
                    const NeverScrollableScrollPhysics(),

                    crossAxisCount: 2,

                    mainAxisSpacing: 18,

                    crossAxisSpacing: 18,

                    childAspectRatio: 2.1,

                    children: [

                      ReportSummaryCard(
                        title: "Subscriptions",
                        value: report.totalSubscriptions.toString(),
                        icon: Icons.assignment,
                        color: Colors.blue,
                      ),

                      ReportSummaryCard(
                        title: "Revenue",
                        value:
                        "₹${report.totalRevenue.toStringAsFixed(2)}",
                        icon: Icons.currency_rupee,
                        color: Colors.green,
                      ),

                      ReportSummaryCard(
                        title: "Visits",
                        value: report.totalVisits.toString(),
                        icon: Icons.home_repair_service,
                        color: Colors.orange,
                      ),

                      ReportSummaryCard(
                        title: "Payout Released",
                        value:
                        "₹${report.totalPayoutsReleased.toStringAsFixed(0)}",
                        icon: Icons.payments,
                        color: Colors.deepPurple,
                      ),

                    ],
                  ),

                  const SizedBox(height: 30),

                  Card(
                    child: SizedBox(
                      height: 220,
                      child: Center(
                        child: Text(
                          "Revenue Chart\n(Coming Soon)",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Card(
                    child: SizedBox(
                      height: 180,
                      child: Center(
                        child: Text(
                          "Monthly Report\n(Coming Soon)",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}