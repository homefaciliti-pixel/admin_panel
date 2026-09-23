import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../AMC_ViewModel/partner Payment/ReleasePaymentViewModel.dart';
import '../../AMC_ViewModel/partner Payment/partner_payment_viewmodel.dart';
import '../../Widget/common resuse/aap_empty_view.dart';
import '../../Widget/common resuse/app_loading_view.dart';
import '../../Widget/common resuse/app_search_field.dart';
import '../../Widget/partnerpayment/partner_payment_card.dart';
import '../../Widget/partnerpayment/payment_summary_card.dart';
import '../Partner payment/partner_payment_details_screen.dart';

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
              hint: "Search Partner / Phone / AMC ID",
              onChanged: (value) {
                context
                    .read<PartnerPaymentViewModel>()
                    .search(value);
              },
            ),

            const SizedBox(height: 20),

            Consumer<PartnerPaymentViewModel>(
              builder: (_, vm, __) {
                return PaymentSummaryCard(
                  pendingAmount: vm.pendingAmount,
                  paidAmount: vm.releasedAmount,
                  totalPartners: vm.totalPartners,
                  totalPayments: vm.totalPayments,
                );
              },
            ),

            const SizedBox(height: 20),

            Consumer<PartnerPaymentViewModel>(
              builder: (_, vm, __) {
                return Wrap(
                  spacing: 10,
                  children: [

                    _chip(vm, "All"),

                    _chip(vm, "Pending"),

                    _chip(vm, "Released"),

                  ],
                );
              },
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Consumer<PartnerPaymentViewModel>(
                builder: (_, vm, __) {

                  if (vm.loading) {
                    return const AppLoadingView();
                  }

                  if (vm.error != null) {
                    return Center(
                      child: Text(vm.error!),
                    );
                  }

                  if (vm.filteredPayments.isEmpty) {
                    return const AppEmptyView(
                      title: "No Payments Found",
                      icon: Icons.account_balance_wallet,
                    );
                  }

                  return RefreshIndicator(

                    onRefresh: vm.refresh,

                    child: ListView.builder(

                      itemCount: vm.filteredPayments.length,

                      itemBuilder: (_, index) {

                        final payment =
                        vm.filteredPayments[index];

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

                          onMarkPaid: payment.status
                              .toLowerCase() ==
                              "pending"
                              ? () async {

                            final releaseVm =
                            context.read<
                                ReleasePaymentViewModel>();

                            final success =
                            await releaseVm
                                .releasePayment(
                              payment.paymentId,
                            );

                            if (success) {

                              ScaffoldMessenger.of(
                                  context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Payment released successfully",
                                  ),
                                ),
                              );

                              vm.fetchPayments();

                            } else {

                              ScaffoldMessenger.of(
                                  context)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text(
                                    releaseVm.message,
                                  ),
                                ),
                              );
                            }
                          }
                              : null,
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