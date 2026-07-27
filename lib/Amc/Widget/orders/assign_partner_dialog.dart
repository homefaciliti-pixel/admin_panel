import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../AMC_ViewModel/assign partner viewmodel/assign_partner_viewmodel.dart';
import '../../AMC_ViewModel/orders/amc_view_model.dart';
import '../../Amc_Model/amc_order_model.dart';
import '../../Amc_Model/partner_dropdown_model.dart';

class AssignPartnerDialog extends StatefulWidget {
  final AmcOrderModel order;

  const AssignPartnerDialog({super.key, required this.order});

  @override
  State<AssignPartnerDialog> createState() => _AssignPartnerDialogState();
}

class _AssignPartnerDialogState extends State<AssignPartnerDialog> {
  final TextEditingController searchController = TextEditingController();

  List<PartnerDropdownModel> filteredPartners = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final vm = context.read<AssignPartnerViewModel>();

      await vm.fetchPartners();

      if (mounted) {
        setState(() {
          filteredPartners = List.from(vm.partners);
        });
      }
    });
  }

  void _search(String value) {
    final vm = context.read<AssignPartnerViewModel>();

    setState(() {
      if (value.isEmpty) {
        filteredPartners = List.from(vm.partners);
      } else {
        filteredPartners = vm.partners.where((e) {
          return e.name.toLowerCase().contains(value.toLowerCase()) ||
              e.mobile.contains(value);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),

      title: const Text("Assign Partner"),

      content: SizedBox(
        width: 450,

        child: Consumer<AssignPartnerViewModel>(
          builder: (context, vm, child) {
            if (vm.loading && vm.partners.isEmpty) {
              return const SizedBox(
                height: 180,
                child: Center(child: CircularProgressIndicator()),
              );
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                TextField(
                  controller: searchController,
                  onChanged: _search,

                  decoration: InputDecoration(
                    hintText: "Search Partner",

                    prefixIcon: const Icon(Icons.search),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                Container(
                  height: 280,

                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),

                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: filteredPartners.isEmpty
                      ? const Center(child: Text("No Partner Found"))
                      : ListView.builder(
                          itemCount: filteredPartners.length,

                          itemBuilder: (_, index) {
                            final partner = filteredPartners[index];

                            return RadioListTile<PartnerDropdownModel>(
                              value: partner,

                              groupValue: vm.selectedPartner,

                              onChanged: (value) {
                                if (value != null) {
                                  vm.selectPartner(value);
                                }
                              },

                              title: Text(partner.name),

                              subtitle: Text(partner.mobile),
                            );
                          },
                        ),
                ),

                if (vm.selectedPartner != null) ...[
                  const SizedBox(height: 18),

                  Card(
                    color: Colors.blue.shade50,

                    child: Padding(
                      padding: const EdgeInsets.all(15),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          const Text(
                            "Selected Partner",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),

                          const SizedBox(height: 10),

                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blue.shade100,

                                child: const Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                ),
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text(
                                      vm.selectedPartner!.name,

                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    Text(vm.selectedPartner!.mobile),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },

          child: const Text("Cancel"),
        ),

        Consumer<AssignPartnerViewModel>(
          builder: (context, vm, child) {
            return FilledButton.icon(
              icon: vm.loading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.person_add),

              label: const Text("Assign Partner"),

              onPressed: vm.loading || vm.selectedPartner == null
                  ? null
                  : () async {
                      final success = await vm.assignPartner(widget.order.id);

                      if (!mounted) return;

                      if (success) {
                        await context.read<AmcOrderViewModel>().fetchOrders();

                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Partner Assigned Successfully"),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(vm.message ?? "Assign Failed"),
                          ),
                        );
                      }
                    },
            );
          },
        ),
      ],
    );
  }
}
