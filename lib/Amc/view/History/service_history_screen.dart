import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../AMC_ViewModel/service_history/service_history_viewmodel.dart';
import '../../Amc_Model/active_amc_model.dart';
import '../../Widget/book_service/customer_info_card.dart';
import '../../Widget/book_service/history_card.dart';
import '../../Widget/book_service/visit_summary_card.dart';
import '../../Widget/common resuse/app_loading_view.dart';
import '../../Widget/common resuse/app_section_title.dart';


class ServiceHistoryScreen extends StatefulWidget {
  final ActiveAmcModel amc;

  const ServiceHistoryScreen({
    super.key,
    required this.amc,
  });

  @override
  State<ServiceHistoryScreen> createState() =>
      _ServiceHistoryScreenState();
}

class _ServiceHistoryScreenState
    extends State<ServiceHistoryScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ServiceHistoryViewModel>().fetchHistory();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        title: const Text("Service History"),
      ),

      body: Consumer<ServiceHistoryViewModel>(
        builder: (context, vm, child) {

          if (vm.loading) {
            return const AppLoadingView();
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Customer Header
                CustomerInfoCard(
                  amc: widget.amc,
                  title: "Customer Information",
                  showStatus: true,
                ),

                const SizedBox(height: 20),

                /// Visit Summary
                VisitSummaryCard(
                  amc: widget.amc,
                ),

                const SizedBox(height: 25),

                const AppSectionTitle(
                  title: "Visit Timeline",
                ),

                const SizedBox(height: 15),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: vm.history.length,
                  itemBuilder: (context, index) {

                    return HistoryCard(
                      history: vm.history[index],
                    );

                  },
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}