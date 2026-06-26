import 'package:admin_panel/widgets/common/app_table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../service_Api/Earnings/Subscriptions/subscription_auth.dart';

class SubscriptionsEarningScreen extends StatefulWidget {
  const SubscriptionsEarningScreen({super.key});

  @override
  State<SubscriptionsEarningScreen> createState() =>
      _SubscriptionsEarningScreenState();
}

class _SubscriptionsEarningScreenState
    extends State<SubscriptionsEarningScreen> {
  @override
  void initState() {
    super.initState();

    /// Screen open hote hi API call



    Future.microtask(() {
      context.read<SubscriptionAuth>().loadSubscriptions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SubscriptionAuth>(
      builder: (context, vm, child) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// =====================================
              /// PAGE HEADER
              /// =====================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// LEFT TITLE
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Subscriptions",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Earnings > Subscriptions",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),

                  /// SEARCH FIELD
                  SizedBox(
                    width: 260,
                    child: TextField(
                      onChanged: vm.searchSubscriptions,
                      decoration: InputDecoration(
                        hintText: "Search Subscription",
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              /// =====================================
              /// LOADING / ERROR / EMPTY STATE
              /// =====================================
              if (vm.isLoading)
                const Expanded(child: AppTableShimmer(rows: 8, columns: 7))
              else if (vm.error != null)
                Expanded(
                  child: Center(
                    child: Text(
                      vm.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                )
              else if (vm.subscriptionEarnings.isEmpty)
                const Expanded(
                  child: Center(child: Text("No Subscription Found")),
                )
              else ...[
                /// =====================================
                /// SUMMARY CARDS
                /// =====================================
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    _summaryCard(
                      title: "Total Subscription Earnings",
                      value:
                          "₹${vm.totalSubscriptionEarning.toStringAsFixed(0)}",
                      icon: Icons.workspace_premium,
                    ),
                    _summaryCard(
                      title: "Total Plans",
                      value: "${vm.totalSubscriptionCount}",
                      icon: Icons.receipt_long,
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                /// =====================================
                /// SUBSCRIPTIONS TABLE
                /// =====================================
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Scrollbar(
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width - 320,
                            ),
                            child: DataTable(
                              headingRowColor: WidgetStateProperty.all(
                                const Color(0xff111827),
                              ),
                              headingTextStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              columns: const [
                                DataColumn(label: Text("ID")),
                                DataColumn(label: Text("PARTNER NAME")),
                                DataColumn(label: Text("AMOUNT")),
                                DataColumn(label: Text("PAYMENT METHOD")),
                                DataColumn(label: Text("PURCHASE DATE")),
                                DataColumn(label: Text("STATUS")),
                              ],
                              rows: vm.subscriptionEarnings.map((item) {
                                return DataRow(
                                  cells: [
                                    DataCell(Text(item.id.toString())),
                                    DataCell(Text(item.partnerName)),
                                    DataCell(
                                      Text(
                                        "₹${item.amount.toStringAsFixed(0)}",
                                      ),
                                    ),
                                    DataCell(Text(item.paymentMethod)),
                                    DataCell(Text(item.purchaseDate)),
                                    DataCell(Text(item.status)),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _summaryCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
              color: const Color(0xff111827),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
