import 'package:admin_panel/Amc/view/Partner%20payment/partner_payment_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../AMC_ViewModel/partner Payment/partner_payment_viewmodel.dart';
import '../../Widget/common resuse/aap_empty_view.dart';
import '../../Widget/common resuse/app_loading_view.dart';
import '../../Widget/common resuse/app_search_field.dart';

import '../../Widget/partnerpayment/partner_payment_card.dart';
import '../../Widget/partnerpayment/payment_summary_card.dart';


class PartnerPaymentScreen extends StatefulWidget {
  const PartnerPaymentScreen({super.key});

  @override
  State<PartnerPaymentScreen> createState() =>
      _PartnerPaymentScreenState();
}

class _PartnerPaymentScreenState
    extends State<PartnerPaymentScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PartnerPaymentViewModel>().fetchPayments();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        title: const Text("Partner Payments"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              "Partner Payments",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Manage all partner payments",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            AppSearchField(
              hint: "Search Partner / Payment ID / Order ID",
              onChanged: (value) {
                context
                    .read<PartnerPaymentViewModel>()
                    .search(value);
              },
            ),
            Consumer<PartnerPaymentViewModel>(
              builder: (_, vm, _) {
                return PaymentSummaryCard(
                  pendingAmount: vm.totalPendingAmount,
                  paidAmount: vm.totalPaidAmount,
                  totalPartners: vm.totalPartners,
                  totalPayments: vm.totalPayments,
                );
              },
            ),




            const SizedBox(height: 20),

            Consumer<PartnerPaymentViewModel>(
              builder: (context, vm, child) {

                return Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [

                    _chip(vm, "All"),

                    _chip(vm, "Pending"),

                    _chip(vm, "Paid"),

                    _chip(vm, "Processing"),

                    _chip(vm, "Failed"),

                  ],
                );
              },
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Consumer<PartnerPaymentViewModel>(
                builder: (context, vm, child) {

                  if (vm.loading) {
                    return const AppLoadingView();
                  }

                  if (vm.filteredList.isEmpty) {
                    return const AppEmptyView(
                      title: "No Payments Found",
                      icon: Icons.account_balance_wallet_outlined,
                    );
                  }

                  return RefreshIndicator(

                    onRefresh: vm.refresh,

                    child: ListView.builder(

                      itemCount: vm.filteredList.length,

                      itemBuilder: (context, index) {

                        final payment =
                        vm.filteredList[index];

                        return PartnerPaymentCard(

                          payment: payment,

                          onView: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    PartnerPaymentDetailsScreen(
                                      payment: payment,
                                    ),
                              ),
                            );

                          },

                          onMarkPaid: () async {

                            await vm.markAsPaid(
                              payment.paymentId,
                              "TXN${DateTime.now().millisecondsSinceEpoch}",
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
      PartnerPaymentViewModel vm,
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