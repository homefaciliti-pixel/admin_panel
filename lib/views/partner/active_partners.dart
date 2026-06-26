import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../service_Api/Activepartners/active_partner_auth.dart';
import '../../service_model/active_partners_model/active_partner_model.dart';
import '../../widgets/common/app_table_shimmer.dart';
import '../../widgets/partner/active_partner/active_partner_table.dart';
import '../dashboard/radar_map_widget.dart';

class ActivePartnerScreen extends StatefulWidget {
  const ActivePartnerScreen({super.key});

  @override
  State<ActivePartnerScreen> createState() => _ActivePartnerScreenState();
}

class _ActivePartnerScreenState extends State<ActivePartnerScreen> {
  final TextEditingController searchController = TextEditingController();
  bool showDistrictsList = false;
  String? selectedDistrict;

  Map<String, List<ActivePartnerModel>> _groupPartnersByDistrict(
    List<ActivePartnerModel> partners,
  ) {
    final Map<String, List<ActivePartnerModel>> grouped = {};
    for (var p in partners) {
      final area = p.area;
      final parts = area.split(',');
      final districtName = parts.isNotEmpty ? parts.last.trim() : 'Unknown';
      if (districtName.isEmpty) continue;
      if (!grouped.containsKey(districtName)) {
        grouped[districtName] = [];
      }
      grouped[districtName]!.add(p);
    }
    return grouped;
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ActivePartnerAuth>().getActivePartners();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ActivePartnerAuth>(context);
    final grouped = _groupPartnersByDistrict(vm.partners);
    final districts = grouped.keys.toList()
      ..sort((a, b) => grouped[b]!.length.compareTo(grouped[a]!.length));

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // TITLE & TOGGLE BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Active Partners",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          showDistrictsList = false;
                          selectedDistrict = null;
                        });
                      },
                      icon: const Icon(Icons.table_chart),
                      label: const Text("Table View"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: !showDistrictsList
                            ? const Color(0xff1e3a8a)
                            : Colors.grey.shade200,
                        foregroundColor: !showDistrictsList
                            ? Colors.white
                            : Colors.black87,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          showDistrictsList = true;
                          selectedDistrict = null;
                        });
                      },
                      icon: const Icon(Icons.location_city),
                      label: const Text("District Tracker"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: showDistrictsList
                            ? const Color(0xff1e3a8a)
                            : Colors.grey.shade200,
                        foregroundColor: showDistrictsList
                            ? Colors.white
                            : Colors.black87,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            // SEARCH (Only show in Table View)
            if (!showDistrictsList) ...[
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: "Search Partner...",
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],

            // TABLE or DISTRICTS or MAP
            Expanded(
              child: vm.isLoading
                  ? const AppTableShimmer(rows: 8, columns: 9)
                  : showDistrictsList
                  ? (selectedDistrict == null
                        ? (districts.isEmpty
                              ? const Center(
                                  child: Text(
                                    "No active districts found.",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: districts.length,
                                  itemBuilder: (context, index) {
                                    final district = districts[index];
                                    final count = grouped[district]!.length;
                                    return Card(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 4,
                                      ),
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 8,
                                            ),
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.blue.shade50,
                                          child: Icon(
                                            Icons.location_city,
                                            color: Colors.blue.shade800,
                                          ),
                                        ),
                                        title: Text(
                                          district,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 6,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: Colors.green.shade50,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                  color: Colors.green.shade200,
                                                ),
                                              ),
                                              child: Text(
                                                "$count Active",
                                                style: TextStyle(
                                                  color: Colors.green.shade800,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            const Icon(
                                              Icons.arrow_forward_ios,
                                              size: 16,
                                              color: Colors.grey,
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          setState(() {
                                            selectedDistrict = district;
                                          });
                                        },
                                      ),
                                    );
                                  },
                                ))
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.arrow_back),
                                    onPressed: () {
                                      setState(() {
                                        selectedDistrict = null;
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Tracker - $selectedDistrict",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade50,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      "${grouped[selectedDistrict!]?.length ?? 0} Active Partners Online",
                                      style: TextStyle(
                                        color: Colors.blue.shade800,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Expanded(
                                child: RadarMapWidget(
                                  activePartners:
                                      (grouped[selectedDistrict!] ?? [])
                                          .map(
                                            (p) => {
                                              'partnerId': p.partnerId,
                                              'profileImage': p.profileImage,
                                              'name': p.name,
                                              'phone': p.phone,
                                              'category': p.category,
                                              'subCategory': p.subCategory,
                                              'area': p.area,
                                              'latitude': p.latitude,
                                              'longitude': p.longitude,
                                              'currentOrders': p.currentOrders,
                                              'isOnline': p.isOnline,
                                              'activeAt': p.activeAt,
                                              'lastActive': p.lastActive,
                                            },
                                          )
                                          .toList(),
                                ),
                              ),
                            ],
                          ))
                  : ActivePartnerTable(partners: vm.partners, vm: vm),
            ),

            // PAGINATION (dummy, Only show in Table View)
            if (!showDistrictsList) ...[
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text("Previous"),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "1",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  OutlinedButton(onPressed: () {}, child: const Text("Next")),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
