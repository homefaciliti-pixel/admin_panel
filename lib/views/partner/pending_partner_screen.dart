import 'package:admin_panel/widgets/common/app_table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../service_Api/partner/partner_auth.dart';
import '../../service_model/partner/partner_model.dart';
import '../../widgets/partner/partner_filter_bar.dart';
import '../../widgets/partner/partner_table.dart';
import 'partner_details_screen.dart';

class PendingPartnerScreen extends StatefulWidget {
  const PendingPartnerScreen({super.key});

  @override
  State<PendingPartnerScreen> createState() =>
      _PendingPartnerScreenState();
}

class _PendingPartnerScreenState
    extends State<PendingPartnerScreen> {

  bool _loaded = false;

  final TextEditingController _searchController =
  TextEditingController();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_loaded) {
      _loaded = true;

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final vm = context.read<PartnerAuth>();

        // Category / State / City / Locality backend se
        await vm.loadFilterOptions();

        // Saare pending partners load honge
        await vm.loadPendingPartners();
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PartnerAuth>(
      builder: (context, vm, child) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [

              // ============================
              // HEADER
              // ============================

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Pending Approval",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight:
                            FontWeight.w800,
                            color:
                            Color(0xff111827),
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          "Review and approve new partner registrations",
                          style: TextStyle(
                            color:
                            Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color:
                      const Color(0xffFFF7ED),
                      borderRadius:
                      BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.pending_actions,
                          color:
                          Color(0xffEA580C),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "${vm.filteredCount} Pending",
                          style: const TextStyle(
                            color:
                            Color(0xffC2410C),
                            fontWeight:
                            FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // ============================
              // SEARCH
              // ============================


              const SizedBox(height: 14),

              // ============================
              // FILTER BAR
              // ============================

              PartnerFilterBar(

                isPending: true,
              ),

              const SizedBox(height: 18),

              // ============================
              // TODAY INDICATOR
              // ============================

              if (vm.selectedPendingDate ==
                  'today')
                Container(
                  margin:
                  const EdgeInsets.only(
                    bottom: 14,
                  ),
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color:
                    const Color(0xffEFF6FF),
                    borderRadius:
                    BorderRadius.circular(10),
                    border: Border.all(
                      color:
                      const Color(0xffBFDBFE),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize:
                    MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.today_outlined,
                        size: 18,
                        color:
                        Color(0xff2563EB),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Showing today's pending registrations",
                        style: TextStyle(
                          color:
                          Color(0xff1D4ED8),
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

              // ============================
              // TABLE
              // ============================

              Expanded(
                child: vm.isLoading
                    ? const AppTableShimmer()
                    : vm.partners.isEmpty
                    ? _emptyState()
                    : PartnerTable(

                  /// IMPORTANT FIX
                  partners:
                  vm.paginatedPartners,

                  vm: vm,
                  isPending: true,

                  onPartnerTap:
                      (PartnerModel item) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            PartnerDetailsScreen(
                              partner: item,
                            ),
                      ),
                    );
                  },

                  onEditTap:
                      (PartnerModel item) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            PartnerDetailsScreen(
                              partner: item,
                            ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 14),

              _pagination(vm),
            ],
          ),
        );
      },
    );
  }

  Widget _emptyState() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(16),
      ),
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.task_alt_rounded,
              size: 60,
              color: Color(0xff9CA3AF),
            ),
            SizedBox(height: 12),
            Text(
              "No pending partners found",
              style: TextStyle(
                fontSize: 17,
                fontWeight:
                FontWeight.w700,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "There are no partners matching the selected filters.",
              style: TextStyle(
                color:
                Color(0xff6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pagination(PartnerAuth vm) {
    return Container(
      padding:
      const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xffE5E7EB),
        ),
      ),
      child: Row(
        children: [
          const Text("Show"),

          const SizedBox(width: 10),

          DropdownButton<int>(
            value: [10, 20, 50, 100].contains(vm.selectedEntries)
                ? vm.selectedEntries
                : 10,
            underline: const SizedBox(),
            items: [10, 20, 50, 100]
                .map(
                  (e) => DropdownMenuItem<int>(
                value: e,
                child: Text("$e"),
              ),
            )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                vm.changeEntries(value);
              }
            },
          ),

          const SizedBox(width: 6),

          const Text("entries"),

          const Spacer(),

          Text(
            "${vm.partners.length} results",
            style: const TextStyle(
              color: Color(0xff6B7280),
            ),
          ),

          const SizedBox(width: 20),

          IconButton(
            onPressed:
            vm.currentPage > 1
                ? vm.previousPage
                : null,
            icon:
            const Icon(
              Icons.chevron_left,
            ),
          ),

          Container(
            padding:
            const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color:
              const Color(0xff111827),
              borderRadius:
              BorderRadius.circular(9),
            ),
            child: Text(
              "${vm.currentPage} / ${vm.totalPages}",
              style: const TextStyle(
                color: Colors.white,
                fontWeight:
                FontWeight.w600,
              ),
            ),
          ),

          IconButton(
            onPressed:
            vm.currentPage <
                vm.totalPages
                ? vm.nextPage
                : null,
            icon:
            const Icon(
              Icons.chevron_right,
            ),
          ),
        ],
      ),
    );
  }
}