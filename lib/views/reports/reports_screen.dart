import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/reports_viewmodels/reports_viewmodel.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ReportsViewModel>(
      builder: (context, vm, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// =====================================
                /// PAGE HEADER
                /// =====================================

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    /// TITLE
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        const Text(
                          "Reports",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          "Home > Reports",
                          style: TextStyle(
                            color:
                            Colors.grey.shade600,

                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),

                    /// EXPORT BUTTON
                    _premiumPrimaryButton(

                      icon:
                      Icons.picture_as_pdf,

                      label:
                      "Export ${_exportLabel(vm)} PDF",

                      onTap: () async {
                        await vm.exportCurrentTabPdf();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${_exportLabel(vm)} PDF Exported"),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// =====================================
                /// FILTER SECTION
                /// =====================================

                Container(

                  padding:
                  const EdgeInsets.all(18),

                  decoration: BoxDecoration(

                    color: Colors.white,

                    borderRadius:
                    BorderRadius.circular(18),

                    boxShadow: [

                      BoxShadow(

                        color:
                        Colors.black.withOpacity(0.04),

                        blurRadius: 10,

                        offset:
                        const Offset(0, 4),
                      ),
                    ],
                  ),

                  child: Wrap(

                    spacing: 14,
                    runSpacing: 14,

                    crossAxisAlignment:
                    WrapCrossAlignment.center,

                    children: [

                      /// START DATE
                      _dateButton(

                        icon:
                        Icons.date_range,

                        label:
                        vm.startDate == null

                            ? "Start Date"

                            : vm.startDate!
                            .toString()
                            .split(" ")
                            .first,

                        onTap: () async {

                          final picked =
                          await showDatePicker(

                            context: context,

                            initialDate:
                            vm.startDate ??
                                DateTime.now(),

                            firstDate:
                            DateTime(2024),

                            lastDate:
                            DateTime(2030),
                          );

                          if (picked != null) {

                            vm.setStartDate(
                              picked,
                            );
                          }
                        },
                      ),

                      /// END DATE
                      _dateButton(

                        icon:
                        Icons.date_range,

                        label:
                        vm.endDate == null

                            ? "End Date"

                            : vm.endDate!
                            .toString()
                            .split(" ")
                            .first,

                        onTap: () async {

                          final picked =
                          await showDatePicker(

                            context: context,

                            initialDate:
                            vm.endDate ??
                                DateTime.now(),

                            firstDate:
                            DateTime(2024),

                            lastDate:
                            DateTime(2030),
                          );

                          if (picked != null) {

                            vm.setEndDate(
                              picked,
                            );
                          }
                        },
                      ),

                      /// APPLY FILTER
                      _premiumDarkButton(

                        label:
                        "Apply Filter",

                        icon:
                        Icons.filter_alt_rounded,

                        onTap:
                        vm.applyFilters,
                      ),

                      /// RESET FILTER
                      _premiumOutlinedButton(

                        label:
                        "Reset",

                        icon:
                        Icons.refresh_rounded,

                        onTap:
                        vm.resetFilters,
                      ),

                      /// SEARCH
                      SizedBox(

                        width: 260,

                        child: TextField(

                          onChanged: (value) {

                            switch (
                            vm.currentTab
                            ) {

                              case ReportsTab.users:
                                vm.searchUsers(value);
                                break;

                              case ReportsTab.partners:
                                vm.searchPartners(value);
                                break;

                              case ReportsTab.earnings:
                                vm.searchEarnings(value);
                                break;

                              case ReportsTab.subscriptions:
                                vm.searchSubscriptions(value);
                                break;
                            }
                          },

                          decoration: InputDecoration(

                            hintText:
                            _searchHint(vm),

                            prefixIcon:
                            const Icon(Icons.search),

                            filled: true,

                            fillColor:
                            Colors.white,

                            contentPadding:
                            const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),

                            border:
                            OutlineInputBorder(

                              borderRadius:
                              BorderRadius.circular(14),

                              borderSide:
                              BorderSide.none,
                            ),

                            enabledBorder:
                            OutlineInputBorder(

                              borderRadius:
                              BorderRadius.circular(14),

                              borderSide:
                              BorderSide(

                                color:
                                Colors.grey.shade300,
                              ),
                            ),

                            focusedBorder:
                            OutlineInputBorder(

                              borderRadius:
                              BorderRadius.circular(14),

                              borderSide:
                              const BorderSide(

                                color:
                                Color(0xff111827),

                                width: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// =====================================
                /// TABS
                /// =====================================

                Container(

                  padding:
                  const EdgeInsets.all(8),

                  decoration: BoxDecoration(

                    color: Colors.white,

                    borderRadius:
                    BorderRadius.circular(16),

                    boxShadow: [

                      BoxShadow(

                        color:
                        Colors.black.withOpacity(0.04),

                        blurRadius: 10,

                        offset:
                        const Offset(0, 4),
                      ),
                    ],
                  ),

                  child: Row(
                    children: [

                      _tabButton(
                        vm,
                        ReportsTab.users,
                        "User Reports",
                      ),

                      _tabButton(
                        vm,
                        ReportsTab.partners,
                        "Partner Reports",
                      ),

                      _tabButton(
                        vm,
                        ReportsTab.earnings,
                        "Earnings Reports",
                      ),

                      _tabButton(
                        vm,
                        ReportsTab.subscriptions,
                        "Subscription Reports",
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// =====================================
                /// TABLE
                /// =====================================

                Container(

                  width: double.infinity,

                  decoration: BoxDecoration(

                    color: Colors.white,

                    borderRadius:
                    BorderRadius.circular(18),

                    boxShadow: [

                      BoxShadow(

                        color:
                        Colors.black.withOpacity(0.04),

                        blurRadius: 12,

                        offset:
                        const Offset(0, 4),
                      ),
                    ],
                  ),

                  child: ClipRRect(

                    borderRadius:
                    BorderRadius.circular(18),

                    child:
                    _buildCurrentTable(vm),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// =====================================
  /// pdf EXPORT LABEL
  /// =====================================

  String _exportLabel(
      ReportsViewModel vm,
      ) {

    switch (vm.currentTab) {

      case ReportsTab.users:
        return "Users";

      case ReportsTab.partners:
        return "Partners";

      case ReportsTab.earnings:
        return "Earnings";

      case ReportsTab.subscriptions:
        return "Subscriptions";
    }
  }

  /// =====================================
  /// SEARCH HINT
  /// =====================================

  String _searchHint(
      ReportsViewModel vm,
      ) {

    switch (vm.currentTab) {

      case ReportsTab.users:
        return "Search User";

      case ReportsTab.partners:
        return "Search Partner";

      case ReportsTab.earnings:
        return "Search Earning";

      case ReportsTab.subscriptions:
        return "Search Subscription";
    }
  }

  /// =====================================
  /// PREMIUM PRIMARY BUTTON
  /// =====================================

  Widget _premiumPrimaryButton({

    required IconData icon,

    required String label,

    required VoidCallback onTap,
  }) {

    return Material(

      color:
      Colors.transparent,

      child: InkWell(

        onTap: onTap,

        borderRadius:
        BorderRadius.circular(16),

        child: Container(

          padding:
          const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 14,
          ),

          decoration: BoxDecoration(

            gradient:
            const LinearGradient(

              colors: [

                Color(0xff111827),

                Color(0xff374151),
              ],

              begin:
              Alignment.topLeft,

              end:
              Alignment.bottomRight,
            ),

            borderRadius:
            BorderRadius.circular(16),

            boxShadow: [

              BoxShadow(

                color:
                Colors.black.withOpacity(0.12),

                blurRadius: 14,

                offset:
                const Offset(0, 6),
              ),
            ],
          ),

          child: Row(

            mainAxisSize:
            MainAxisSize.min,

            children: [

              Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),

              const SizedBox(width: 10),

              Text(

                label,

                style: const TextStyle(

                  color:
                  Colors.white,

                  fontWeight:
                  FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// =====================================
  /// PREMIUM DARK BUTTON
  /// =====================================

  Widget _premiumDarkButton({

    required String label,

    required IconData icon,

    required VoidCallback onTap,
  }) {

    return Material(

      color:
      Colors.transparent,

      child: InkWell(

        onTap: onTap,

        borderRadius:
        BorderRadius.circular(14),

        child: Container(

          padding:
          const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 14,
          ),

          decoration: BoxDecoration(

            color:
            const Color(0xff111827),

            borderRadius:
            BorderRadius.circular(14),

            boxShadow: [

              BoxShadow(

                color:
                Colors.black.withOpacity(0.10),

                blurRadius: 12,

                offset:
                const Offset(0, 6),
              ),
            ],
          ),

          child: Row(

            mainAxisSize:
            MainAxisSize.min,

            children: [

              Icon(
                icon,
                color: Colors.white,
                size: 18,
              ),

              const SizedBox(width: 8),

              Text(

                label,

                style: const TextStyle(

                  color:
                  Colors.white,

                  fontWeight:
                  FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// =====================================
  /// PREMIUM OUTLINED BUTTON
  /// =====================================

  Widget _premiumOutlinedButton({

    required String label,

    required IconData icon,

    required VoidCallback onTap,
  }) {

    return Material(

      color:
      Colors.transparent,

      child: InkWell(

        onTap: onTap,

        borderRadius:
        BorderRadius.circular(14),

        child: Container(

          padding:
          const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 14,
          ),

          decoration: BoxDecoration(

            color:
            Colors.white,

            borderRadius:
            BorderRadius.circular(14),

            border: Border.all(
              color:
              Colors.grey.shade300,
            ),
          ),

          child: Row(

            mainAxisSize:
            MainAxisSize.min,

            children: [

              Icon(
                icon,
                color: Colors.black87,
                size: 18,
              ),

              const SizedBox(width: 8),

              Text(

                label,

                style: const TextStyle(

                  color:
                  Colors.black87,

                  fontWeight:
                  FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// =====================================
  /// DATE BUTTON
  /// =====================================

  Widget _dateButton({

    required IconData icon,

    required String label,

    required VoidCallback onTap,
  }) {

    return Material(

      color:
      Colors.transparent,

      child: InkWell(

        onTap: onTap,

        borderRadius:
        BorderRadius.circular(14),

        child: Container(

          padding:
          const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),

          decoration: BoxDecoration(

            color:
            Colors.white,

            borderRadius:
            BorderRadius.circular(14),

            border: Border.all(
              color:
              Colors.grey.shade300,
            ),
          ),

          child: Row(

            mainAxisSize:
            MainAxisSize.min,

            children: [

              Icon(
                icon,
                size: 18,
                color: Colors.black87,
              ),

              const SizedBox(width: 8),

              Text(

                label,

                style: const TextStyle(
                  fontWeight:
                  FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// =====================================
  /// TAB BUTTON
  /// =====================================

  Widget _tabButton(

      ReportsViewModel vm,

      ReportsTab tab,

      String title,
      ) {

    final selected =
        vm.currentTab == tab;

    return Expanded(

      child: Material(

        color:
        Colors.transparent,

        child: InkWell(

          onTap: () {
            vm.changeTab(tab);
          },

          borderRadius:
          BorderRadius.circular(12),

          child: AnimatedContainer(

            duration:
            const Duration(milliseconds: 180),

            padding:
            const EdgeInsets.symmetric(
              vertical: 14,
            ),

            margin:
            const EdgeInsets.symmetric(
              horizontal: 4,
            ),

            decoration: BoxDecoration(

              color:

              selected

                  ? const Color(0xff111827)

                  : Colors.transparent,

              borderRadius:
              BorderRadius.circular(12),

              border: Border.all(

                color:

                selected

                    ? const Color(0xff111827)

                    : Colors.grey.shade200,
              ),
            ),

            alignment:
            Alignment.center,

            child: Text(

              title,

              style: TextStyle(

                color:

                selected

                    ? Colors.white

                    : Colors.black87,

                fontWeight:
                FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// =====================================
  /// CURRENT TABLE
  /// =====================================

  Widget _buildCurrentTable(
      ReportsViewModel vm,
      ) {

    switch (vm.currentTab) {

      case ReportsTab.users:

        return _buildScrollableTable(

          width: 1200,

          header: _tableHeader([
            "ID",
            "USER NAME",
            "MOBILE",
            "CREATED AT",
            "locality",
          ]),

          body: vm.users.isEmpty

              ? _emptyState(
            "No users found",
          )

              : ListView.builder(

            itemCount:
            vm.users.length,

            itemBuilder:
                (context, index) {

              final item =
              vm.users[index];

              return _tableRow([
                item.id.toString(),
                item.userName,
                item.mobile,
                item.createdAt,
                item.locality
              ]);
            },
          ),
        );

      case ReportsTab.partners:

        return _buildScrollableTable(

          width: 1200,

          header: _tableHeader([
            "ID",
            "PARTNER NAME",
            "MOBILE",
            "CREATED AT",
            "locality",

          ]),

          body: vm.partners.isEmpty

              ? _emptyState(
            "No partners found",
          )

              : ListView.builder(

            itemCount:
            vm.partners.length,

            itemBuilder:
                (context, index) {

              final item =
              vm.partners[index];

              return _tableRow([
                item.id.toString(),
                item.partnerName,
                item.mobile,
                item.createdAt,
                item.locality,
              ]);
            },
          ),
        );

      case ReportsTab.earnings:

        return _buildScrollableTable(

          width: 1500,

          header: _tableHeader([
            "ID",
            "SOURCE",
            "TITLE",
            "AMOUNT",
            "PAYMENT METHOD",
            "CREATED AT",
            "locality"
          ]),

          body: vm.earnings.isEmpty

              ? _emptyState(
            "No earnings found",
          )

              : ListView.builder(

            itemCount:
            vm.earnings.length,

            itemBuilder:
                (context, index) {

              final item =
              vm.earnings[index];

              return _tableRow([
                item.id.toString(),
                item.source,
                item.title,
                "Rs ${item.amount}",
                item.paymentMethod,
                item.createdAt,
                item.locality
              ]);
            },
          ),
        );

      case ReportsTab.subscriptions:

        return _buildScrollableTable(

          width: 1400,

          header: _tableHeader([
            "ID",
            "PARTNER NAME",
            "PLAN NAME",
            "AMOUNT",
            "CREATED AT",
            "locality"
          ]),

          body:
          vm.subscriptions.isEmpty

              ? _emptyState(
            "No subscriptions found",
          )

              : ListView.builder(

            itemCount:
            vm.subscriptions.length,

            itemBuilder:
                (context, index) {

              final item =
              vm.subscriptions[index];

              return _tableRow([
                item.id.toString(),
                item.partnerName,
                item.planName,
                "Rs ${item.amount}",
                item.createdAt,
                item.locality
              ]);
            },
          ),
        );
    }
  }

  /// =====================================
  /// TABLE HEADER
  /// =====================================

  Widget _tableHeader(
      List<String> titles,
      ) {

    return Row(

      children:

      titles.map((title) {

        return Expanded(

          child: Padding(

            padding:
            const EdgeInsets.symmetric(
              horizontal: 10,
            ),

            child: Text(

              title,

              style: const TextStyle(

                fontWeight:
                FontWeight.bold,

                fontSize: 13,
              ),
            ),
          ),
        );

      }).toList(),
    );
  }

  /// =====================================
  /// TABLE ROW
  /// =====================================

  Widget _tableRow(
      List<String> values,
      ) {

    return Container(

      padding:
      const EdgeInsets.symmetric(
        vertical: 16,
      ),

      decoration: BoxDecoration(

        border: Border(

          bottom: BorderSide(
            color:
            Colors.grey.shade200,
          ),
        ),
      ),

      child: Row(

        children:

        values.map((value) {

          return Expanded(

            child: Padding(

              padding:
              const EdgeInsets.symmetric(
                horizontal: 10,
              ),

              child: Text(
                value,
              ),
            ),
          );

        }).toList(),
      ),
    );
  }

  /// =====================================
  /// SCROLLABLE TABLE
  /// =====================================

  Widget _buildScrollableTable({

    required double width,

    required Widget header,

    required Widget body,
  }) {

    return SingleChildScrollView(

      scrollDirection:
      Axis.horizontal,

      child: SizedBox(

        width: width,

        child: Column(

          children: [

            Container(

              padding:
              const EdgeInsets.all(14),

              color:
              Colors.blue.shade50,

              child:
              header,
            ),

            SizedBox(
              height: 520,
              child: body,
            ),
          ],
        ),
      ),
    );
  }

  /// =====================================
  /// EMPTY STATE
  /// =====================================

  Widget _emptyState(
      String message,
      ) {

    return Center(

      child: Padding(

        padding:
        const EdgeInsets.all(30),

        child: Text(

          message,

          style: TextStyle(

            color:
            Colors.grey.shade600,

            fontSize: 16,
          ),
        ),
      ),
    );
  }
}