import 'package:admin_panel/widgets/common/app_table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../service_Api/partner/partner_auth.dart';
import '../../service_model/partner/partner_model.dart';
import '../../widgets/partner/partner_filter_bar.dart';
import '../../widgets/partner/partner_table.dart';
import 'partner_details_screen.dart';

class PartnerScreen extends StatefulWidget {
  const PartnerScreen({super.key});

  @override
  State<PartnerScreen> createState() => _PartnerScreenState();
}

class _PartnerScreenState extends State<PartnerScreen> {
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_loaded) {
      _loaded = true;

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final vm = context.read<PartnerAuth>();

        // Category / State / City / Locality backend se load honge
        await vm.loadFilterOptions();

        // Approved partners load honge
        await vm.loadApprovedPartners();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PartnerAuth>(
      builder: (context, vm, child) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Approved Partners",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff111827),
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          "Manage all approved partners",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffECFDF5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.verified,
                          color: Colors.green,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "${vm.paginatedPartners.length} Approved",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff047857),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              const PartnerFilterBar(),

              const SizedBox(height: 18),

              /// PARTNER TABLE
              Expanded(
                child: vm.isLoading
                    ? const AppTableShimmer()
                    : PartnerTable(
                        partners: vm.paginatedPartners,
                        vm: vm,
                        isPending: false,
                        onPartnerTap: (PartnerModel item) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  PartnerDetailsScreen(partner: item),
                            ),
                          );
                        },
                        onEditTap: (PartnerModel item) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  PartnerDetailsScreen(partner: item),
                            ),
                          );
                        },
                      ),
              ),

              const SizedBox(height: 18),

              /// PAGINATION SECTION
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Show",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: DropdownButton<int>(
                            value: vm.selectedEntries,
                            underline: const SizedBox(),
                            items: [10, 20, 50, 100, 200, 500,].map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text("$e"),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                vm.changeEntries(value);
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text("entries"),
                      ],
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: vm.previousPage,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: const Icon(Icons.chevron_left),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xff111827),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "${vm.currentPage}/${vm.totalPages}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: vm.nextPage,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: const Icon(Icons.chevron_right),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
