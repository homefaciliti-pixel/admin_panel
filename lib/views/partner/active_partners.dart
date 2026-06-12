import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../service_Api/Activepartners/active_partner_auth.dart';
import '../../widgets/partner/active_partner/active_partner_table.dart';
import '../dashboard/radar_map_widget.dart';

class ActivePartnerScreen extends StatefulWidget {
  const ActivePartnerScreen({super.key});

  @override
  State<ActivePartnerScreen> createState() =>
      _ActivePartnerScreenState();
}

class _ActivePartnerScreenState
    extends State<ActivePartnerScreen> {

  final TextEditingController searchController =
  TextEditingController();
  bool isMapView = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<ActivePartnerAuth>()
          .getActivePartners();
    });
  }

  @override
  Widget build(BuildContext context) {

    final vm = Provider.of<ActivePartnerAuth>(context);

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            // TITLE & TOGGLE BUTTONS

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Active Partners",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          isMapView = false;
                        });
                      },
                      icon: const Icon(Icons.table_chart),
                      label: const Text("Table View"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: !isMapView ? const Color(0xff1e3a8a) : Colors.grey.shade200,
                        foregroundColor: !isMapView ? Colors.white : Colors.black87,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          isMapView = true;
                        });
                      },
                      icon: const Icon(Icons.map),
                      label: const Text("Map View"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isMapView ? const Color(0xff1e3a8a) : Colors.grey.shade200,
                        foregroundColor: isMapView ? Colors.white : Colors.black87,
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

            if (!isMapView) ...[
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

            // TABLE or MAP

            Expanded(
              child: vm.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : isMapView
                      ? SingleChildScrollView(
                          child: RadarMapWidget(
                            activePartners: vm.partners.map((p) => {
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
                            }).toList(),
                          ),
                        )
                      : ActivePartnerTable(
                          partners: vm.partners,
                          vm: vm,
                        ),
            ),

            // PAGINATION (dummy, Only show in Table View)

            if (!isMapView) ...[
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
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text("Next"),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}