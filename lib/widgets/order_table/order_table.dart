import 'package:flutter/material.dart';

import '../../service_Api/Order/order_auth.dart';
import '../../service_model/order/order_model.dart';


class OrderTable extends StatelessWidget {
  final OrderAuth vm;
  final void Function(OrderModel item) onViewDetails;
  final void Function(OrderModel item) onAssignVendor;
  final void Function(OrderModel item) onEditOrder;

  const OrderTable({
    super.key,
    required this.vm,
    required this.onViewDetails,
    required this.onAssignVendor,
    required this.onEditOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: vm.paginatedOrders.isEmpty
            ? const SizedBox(
          height: 240,
          child: Center(child: Text("No orders found")),
        )
            : Column(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              color: Colors.blue.shade50,
              child: const Row(
                children: [
                  Expanded(flex: 1, child: Text("ID")),
                  Expanded(flex: 3, child: Text("SERVICE REQUEST NUMBER")),
                  Expanded(flex: 2, child: Text("SERVICE NAME")),
                  Expanded(flex: 2, child: Text("SERVICE AMOUNT")),
                  Expanded(flex: 2, child: Text("SLOT TIME")),
                  Expanded(flex: 2, child: Text("SERVICE DATE")),
                  Expanded(flex: 2, child: Text("CITY")),
                  Expanded(flex: 2, child: Text("LOCALITY")),
                  Expanded(flex: 2, child: Text("STATUS")),
                  Expanded(flex: 2, child: Text("VENDOR NAME")),
                  Expanded(flex: 2, child: Text("ASSIGN VENDOR")),
                  Expanded(flex: 1, child: Text("EDIT")),
                  Expanded(flex: 2, child: Text("CREATED AT")),
                ],
              ),
            ),
            const Divider(height: 1),
            SizedBox(
              height: 520,
              child: ListView.builder(
                itemCount: vm.paginatedOrders.length,
                itemBuilder: (context, index) {
                  final item = vm.paginatedOrders[index];

                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(item.id.toString()),
                        ),
                        Expanded(
                          flex: 3,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () => onViewDetails(item),
                            child: Text(
                              item.serviceRequestNumber,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            item.serviceName,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "₹${item.serviceAmount.toStringAsFixed(0)}",
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(item.slotTime),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(item.serviceDate),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(item.city),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(item.locality),
                        ),
                        Expanded(
                          flex: 2,
                          child: _statusChip(item.status),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item.vendorName.isEmpty ? "-" : item.vendorName,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontWeight: FontWeight.w600),
                              ),
                              if (item.vendorMobile.isNotEmpty && item.vendorMobile != '-')
                                Text(
                                  item.vendorMobile,
                                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                                ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: OutlinedButton.icon(
                            onPressed: () => onAssignVendor(item),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xff111827),
                              side: const BorderSide(
                                color: Color(0xff111827),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            icon: const Icon(
                              Icons.person_add_alt_1,
                              size: 18,
                            ),
                            label: const Text("Assign"),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            onPressed: () => onEditOrder(item),
                            icon: const Icon(Icons.edit, color: Colors.blue),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(item.createdAt),
                        ),
                      ],
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

  Widget _statusChip(String status) {
    Color color;

    switch (status.toLowerCase()) {
      case "completed":
      case "complete":
        color = Colors.green;
        break;
      case "assigned":
        color = Colors.blue;
        break;
      case "cancelled":
        color = Colors.red;
        break;
      default:
        color = Colors.orange;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }
}