import 'package:flutter/material.dart';
import 'package:admin_panel/service_Api/partner/partner_auth.dart';

import '../../core/App_permission/app_permission.dart';
import '../../service_model/partner/partner_model.dart';
import '../../views/partner/partner_details_screen.dart';

class PartnerTable extends StatelessWidget {
  // PartnerModel ki typed list
  final List<PartnerModel> partners;

  final bool isPending;

  // API / state handle karne wali class
  final PartnerAuth vm;

  // Row tap ke liye typed callback
  final void Function(PartnerModel item)? onPartnerTap;

  // Edit icon ke liye typed callback
  final void Function(PartnerModel item)? onEditTap;

  const PartnerTable({
    super.key,
    required this.partners,
    required this.vm,
    this.onPartnerTap,
    this.onEditTap,
    this.isPending = false,
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
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          /// =========================
          /// HEADER
          /// =========================
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            decoration: const BoxDecoration(
              color: Color(0xff111827),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
            ),
            child: Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Text("#", style: TextStyle(color: Colors.white)),
                ),
                const Expanded(
                  flex: 3,
                  child: Text("Partner", style: TextStyle(color: Colors.white)),
                ),
                const Expanded(
                  flex: 2,
                  child: Text("Mobile", style: TextStyle(color: Colors.white)),
                ),
                const Expanded(
                  flex: 2,
                  child: Text("City", style: TextStyle(color: Colors.white)),
                ),

                const Expanded(
                  flex: 2,
                  child: Text("State", style: TextStyle(color: Colors.white)),
                ),

                const Expanded(
                  flex: 2,
                  child: Text("Payment", style: TextStyle(color: Colors.white)),
                ),

                if (!isPending)
                  const Expanded(
                    flex: 3,
                    child: Text(
                      "Location (Lat/Lng)",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                if (!isPending)
                  const Expanded(
                    flex: 3,
                    child: Text(
                      "Last Active",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                const Expanded(
                  flex: 2,
                  child: Text(
                    "Created At",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                if (!isPending)
                  const Expanded(
                    flex: 1,
                    child: Text(
                      "Status",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                if (!isPending)
                  const Expanded(
                    flex: 1,
                    child: Text("Edit", style: TextStyle(color: Colors.white)),
                  ),
                const Expanded(
                  flex: 1,
                  child: Text("Delete", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),

          /// =========================
          /// BODY
          /// =========================
          Expanded(
            child: ListView.builder(
              itemCount: partners.length,
              itemBuilder: (context, index) {
                /// IMPORTANT: yahan item ko PartnerModel type diya
                final PartnerModel item = partners[index];

                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                  child: Row(
                    children: [
                      /// SERIAL NO
                      Expanded(flex: 1, child: Text("${index + 1}")),

                      /// PARTNER NAME + EMAIL
                      Expanded(
                        flex: 3,
                        child: InkWell(
                          onTap: () {
                            // Agar callback diya hai to use karo
                            if (onPartnerTap != null) {
                              onPartnerTap!(item);
                              return;
                            }

                            // Fallback: direct details screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    PartnerDetailsScreen(partner: item),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.grey.shade200,
                                backgroundImage: item.image.isNotEmpty
                                    ? NetworkImage(item.image)
                                    : null,
                                child: item.image.isEmpty
                                    ? const Icon(Icons.person)
                                    : null,
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item.category,
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// MOBILE
                      Expanded(
                        flex: 2,
                        child: Text("${item.countryCode} ${item.mobile}"),
                      ),

                      /// CITY
                      Expanded(flex: 2, child: Text(item.city)),
                      Expanded(flex: 2, child: Text(item.state)),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: item.isPaid == "Paid"
                                ? Colors.green.shade100
                                : Colors.red.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            item.isPaid,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: item.isPaid == "Paid"
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),

                      /// LOCATION (LAT/LNG)
                      if (!isPending)
                        Expanded(
                          flex: 3,
                          child: Text(
                            (item.latitude != null &&
                                    item.longitude != null &&
                                    item.latitude!.isNotEmpty &&
                                    item.longitude!.isNotEmpty)
                                ? "${item.latitude}, ${item.longitude}"
                                : "-",
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 13,
                            ),
                          ),
                        ),

                      /// LAST ACTIVE TIME
                      if (!isPending)
                        Expanded(
                          flex: 3,
                          child: Text(
                            (item.locationTime != null &&
                                    item.locationTime!.isNotEmpty)
                                ? _formatLocationTime(item.locationTime!)
                                : "-",
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 13,
                            ),
                          ),
                        ),

                      /// CREATED AT
                      Expanded(flex: 2, child: Text(item.createdAt)),

                      /// STATUS SWITCH
                      if (!isPending)
                        Expanded(
                          flex: 1,
                          child: Switch(
                            value: item.status,
                            onChanged: (value) async {
                              // Status change API call
                              await vm.updatePartner(item.id, {
                                'status': value,
                              });
                            },
                          ),
                        ),

                      /// EDIT ICON
                      if (!isPending)
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              // Agar callback diya hai to use karo
                              if (onEditTap != null) {
                                onEditTap!(item);
                                return;
                              }

                              // Fallback: details screen
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

                      if (AppPermission.isSuperAdmin)
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text("Delete Partner"),
                                  content: const Text(
                                    "Are you sure you want to delete this partner?",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child: const Text("Cancel"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                      child: const Text("Delete"),
                                    ),
                                  ],
                                ),
                              );

                              if (confirm == true) {
                                await vm.deletePartner(item.id);
                              }
                            },
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _formatLocationTime(String timeStr) {
    try {
      final dateTime = DateTime.parse(timeStr).toLocal();
      final day = dateTime.day.toString().padLeft(2, '0');
      final month = dateTime.month.toString().padLeft(2, '0');
      final year = dateTime.year;

      int hour = dateTime.hour;
      final minute = dateTime.minute.toString().padLeft(2, '0');
      final period = hour >= 12 ? 'PM' : 'AM';

      if (hour > 12) hour -= 12;
      if (hour == 0) hour = 12;

      final hourStr = hour.toString().padLeft(2, '0');

      return "$day-$month-$year $hourStr:$minute $period";
    } catch (_) {
      return timeStr;
    }
  }
}
