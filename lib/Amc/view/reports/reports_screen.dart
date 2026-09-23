import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../AMC_ViewModel/amc reports/amc_report_viewmodel.dart';

import '../../Widget/common resuse/aap_empty_view.dart';
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
      context.read<AmcReportViewModel>().fetchReports();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        title: const Text("AMC Reports"),
      ),

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

          if (vm.report == null) {
            return const AppEmptyView(
              title: "No Report Found",
              icon: Icons.analytics_outlined,
            );
          }

          final report = vm.report!;

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
                    "AMC Reports Dashboard",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Overview of AMC performance",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 24),

                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics:
                    const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 2.3,

                    children: [

                      ReportSummaryCard(
                        title: "Subscriptions",
                        value:
                        report.totalSubscriptions.toString(),
                        icon: Icons.subscriptions,
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
                        value:
                        report.totalVisits.toString(),
                        icon: Icons.home_repair_service,
                        color: Colors.orange,
                      ),

                      ReportSummaryCard(
                        title: "Payout Released",
                        value:
                        "₹${report.totalPayoutsReleased.toStringAsFixed(2)}",
                        icon: Icons.payments,
                        color: Colors.purple,
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: const [

                          Icon(
                            Icons.bar_chart,
                            size: 70,
                            color: Colors.grey,
                          ),

                          SizedBox(height: 16),

                          Text(
                            "Revenue & Analytics Charts",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),

                          SizedBox(height: 8),

                          Text(
                            "Charts will appear automatically when backend provides monthly analytics.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
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