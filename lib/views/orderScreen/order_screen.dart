import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../service_Api/Order/order_auth.dart';
import '../../service_Api/partner/partner_auth.dart';
import '../../service_model/order/order_model.dart';
import '../../widgets/order_table/order_table.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _horizontalController = ScrollController();
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_loaded) {
      context.read<OrderAuth>().fetchOrders();
      context.read<PartnerAuth>().loadAllPartners();
      _loaded = true;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderAuth>(
      builder: (context, vm, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Orders",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Home > Orders",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 260,
                    child: TextField(
                      controller: _searchController,
                      onChanged: vm.searchOrder,
                      decoration: InputDecoration(
                        hintText: "Search Order",
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

              const SizedBox(height: 20),

              /// SHOW ENTRIES + PAGINATION TOP
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
                      color: Colors.black.withOpacity(0.04),
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
                            items: [10, 20, 50, 100].map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text("$e"),
                              );
                            }).toList(),
                            onChanged: vm.isLoading
                                ? null
                                : (value) {
                                    if (value != null) vm.changeEntries(value);
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
                            "${vm.currentPage}",
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

              const SizedBox(height: 20),

              /// TABLE
              if (vm.isLoading)
                const SizedBox(
                  height: 300,
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (vm.errorMessage != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        vm.errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: vm.fetchOrders,
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                )
              else
                Scrollbar(
                  controller: _horizontalController,
                  thumbVisibility: true,
                  trackVisibility: true,
                  child: SingleChildScrollView(
                    controller: _horizontalController,
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: 1750,
                      child: OrderTable(
                        vm: vm,
                        onViewDetails: (item) {
                          _showOrderDetails(context, item);
                        },
                        onAssignVendor: (item) {
                          _showAssignVendorSheet(context, vm, item);
                        },
                        onEditOrder: (item) {
                          _showEditOrderDialog(context, vm, item);
                        },
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _showOrderDetails(BuildContext context, OrderModel item) {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Order Details",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _detailChip("Request No", item.serviceRequestNumber),
                      _detailChip("Service", item.serviceName),
                      _detailChip("Status", item.status),
                      _detailChip(
                        "Vendor",
                        item.vendorNumber.isEmpty ? "-" : item.vendorNumber,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _detailCard("ID", item.id.toString()),
                      _detailCard(
                        "Service Request No",
                        item.serviceRequestNumber,
                      ),
                      _detailCard("Service Name", item.serviceName),
                      _detailCard(
                        "Service Amount",
                        "₹${item.serviceAmount.toStringAsFixed(0)}",
                      ),
                      _detailCard("Slot Time", item.slotTime),
                      _detailCard("Service Date", item.serviceDate),
                      _detailCard("City", item.city),
                      _detailCard("Locality", item.locality),
                      _detailCard("Status", item.status),
                      _detailCard(
                        "Vendor Number",
                        item.vendorNumber.isEmpty ? "-" : item.vendorNumber,
                      ),
                      _detailCard(
                        "Vendor Mobile",
                        item.vendorMobile.isEmpty ? "-" : item.vendorMobile,
                      ),
                      _detailCard("Created At", item.createdAt),
                      _detailCard("Address", item.address),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff111827),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 14,
                        ),
                      ),
                      child: const Text("Close"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showAssignVendorSheet(

      BuildContext context,
      OrderAuth vm,
      OrderModel item,
      )


   {


    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        String? selectedMobile = item.vendorMobile.trim().isNotEmpty && item.vendorMobile != '-'
            ? item.vendorMobile
            : null;

        return StatefulBuilder(
          builder: (context, setState) {

            final bool isAssigned = item.vendorMobile.trim().isNotEmpty && item.vendorMobile != '-';




            return Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    "Assign Vendor",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Request No: ${item.serviceRequestNumber}",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 20),

                  Consumer<PartnerAuth>(
                    builder: (context, partnerAuth, child) {
                      if (partnerAuth.isLoading &&
                          partnerAuth.approvedPartners.isEmpty) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final approved = partnerAuth.approvedPartners;

                      if (approved.isEmpty) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.red.shade200,
                            ),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  "No approved partners found.",
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      final hasMatchingPartner = approved.any(
                            (p) => p.mobile == selectedMobile,
                      );

                      final dropdownValue =
                      hasMatchingPartner ? selectedMobile : null;

                      return DropdownButtonFormField<String>(
                        value: dropdownValue,
                        hint: const Text(
                          "Select Approved Partner",
                        ),
                        decoration: InputDecoration(
                          labelText: "Select Partner",
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        items: approved.map((partner) {
                          return DropdownMenuItem<String>(
                            value: partner.mobile,
                            child: Text(
                              "${partner.name} (${partner.mobile})",
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              selectedMobile = val;
                            });
                          }
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 18),

                  Text(
                    isAssigned
                        ? "Assigned to: ${item.vendorMobile}"
                        : "Select approved vendor to assign this order.",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                            ),
                          ),
                          child: const Text("Cancel"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: selectedMobile == null
                              ? null
                              : () async {
                            final ok = await vm.assignVendor(
                              item.id,
                              selectedMobile!,
                            );

                            if (ok && mounted) {
                              Navigator.pop(context);
                            } else if (mounted) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text(
                                    vm.errorMessage ??
                                        "Failed to assign vendor",
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            const Color(0xff111827),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                            ),
                          ),
                          child: const Text("Assign"),
                        ),
                      ),
                    ],
                  ),


                  if (isAssigned) ...[
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          final ok = await vm.unassignVendor(item.id);
                          if (ok && mounted) {
                            Navigator.pop(context);
                          } else if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(vm.errorMessage ?? "Failed to unassign vendor"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text("Unassign Vendor"),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showEditOrderDialog(
    BuildContext context,
    OrderAuth vm,
    OrderModel item,
  ) {
    final statusController = TextEditingController(text: item.status);

    final vendorController = TextEditingController(
      text: item.vendorMobile == '-' ? '' : item.vendorMobile,
    );



    final slotTimeController = TextEditingController(text: item.slotTime);
    final serviceDateController = TextEditingController(text: item.serviceDate);
    final cityController = TextEditingController(text: item.city);
    final localityController = TextEditingController(text: item.locality);
    final addressController = TextEditingController(text: item.address);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Edit Order"),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 520,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _editField(statusController, "Status"),
                  const SizedBox(height: 14),
                  _editField(vendorController, "Vendor Mobile"),
                  const SizedBox(height: 14),
                  _editField(slotTimeController, "Slot Time"),
                  const SizedBox(height: 14),
                  _editField(serviceDateController, "Service Date"),
                  const SizedBox(height: 14),
                  _editField(cityController, "City"),
                  const SizedBox(height: 14),
                  _editField(localityController, "Locality"),
                  const SizedBox(height: 14),
                  _editField(addressController, "Address", maxLines: 3),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: vm.isLoading
                  ? null
                  : () async {

                final ok = await vm.updateOrder(
                  item.id,
                  {
                    'status': statusController.text.trim(),
                    'vendorMobile': vendorController.text.trim(),
                    'slotTime': slotTimeController.text.trim(),
                    'serviceDate': serviceDateController.text.trim(),
                    'city': cityController.text.trim(),
                    'locality': localityController.text.trim(),
                    'address': addressController.text.trim(),
                  },
                );




                      if (ok && context.mounted) {
                        Navigator.pop(dialogContext);
                      }
                    },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Widget _detailCard(String title, String value) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),
          Text(
            value.isEmpty ? "-" : value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _detailChip(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xff111827),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        "$title: $value",
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _editField(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
