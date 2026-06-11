import 'package:flutter/material.dart';
import '../../../service_Api/Activepartners/active_partner_auth.dart';
import '../../../service_model/Active_Partners_model/active_Partnermodel.dart';


class ActivePartnerTable extends StatelessWidget {

  final List<ActivePartnerModel> partners;
  final ActivePartnerAuth vm;

  const ActivePartnerTable({
    super.key,
    required this.partners,
    required this.vm,
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

      child: Column(
        children: [

          // ================= HEADER =================

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 16,
            ),
            decoration: const BoxDecoration(
              color: Color(0xff111827),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
            ),
            child: const Row(
              children: [

                Expanded(
                  flex: 1,
                  child: Text(
                    "#",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                Expanded(
                  flex: 4,
                  child: Text(
                    "Partner",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Text(
                    "Phone",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Text(
                    "Area",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Text(
                    "Orders",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Text(
                    "Status",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Text(
                    "Active At",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Text(
                    "Last Active",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: Text(
                    "Map",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          // ================= BODY =================

          Expanded(
            child: ListView.builder(
              itemCount: partners.length,

              itemBuilder: (context, index) {

                final item = partners[index];

                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),

                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade200,
                      ),
                    ),
                  ),

                  child: Row(
                    children: [

                      // SERIAL

                      Expanded(
                        flex: 1,
                        child: Text("${index + 1}"),
                      ),

                      // PARTNER

                      Expanded(
                        flex: 4,
                        child: Row(
                          children: [

                            CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.grey.shade200,

                              backgroundImage:
                              item.profileImage.isNotEmpty
                                  ? NetworkImage(item.profileImage)
                                  : null,

                              child: item.profileImage.isEmpty
                                  ? const Icon(Icons.person)
                                  : null,
                            ),

                            const SizedBox(width: 14),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
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

                      // PHONE

                      Expanded(
                        flex: 2,
                        child: Text(item.phone),
                      ),

                      // AREA

                      Expanded(
                        flex: 2,
                        child: Text(item.area),
                      ),

                      // CURRENT ORDERS

                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.orange.shade100,
                            borderRadius:
                            BorderRadius.circular(20),
                          ),

                          child: Text(
                            "${item.currentOrders}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      // STATUS

                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),

                          decoration: BoxDecoration(
                            color: item.isOnline
                                ? Colors.green.shade100
                                : Colors.red.shade100,

                            borderRadius:
                            BorderRadius.circular(20),
                          ),

                          child: Text(
                            item.isOnline
                                ? "Online"
                                : "Offline",

                            textAlign: TextAlign.center,

                            style: TextStyle(
                              color: item.isOnline
                                  ? Colors.green
                                  : Colors.red,

                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      // ACTIVE AT

                      Expanded(
                        flex: 2,
                        child: Text(item.activeAt),
                      ),

                      // LAST ACTIVE

                      Expanded(
                        flex: 2,
                        child: Text(item.lastActive),
                      ),

                      // MAP

                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () {

                            // Future:
                            // Open Map Screen

                          },

                          icon: const Icon(
                            Icons.location_on,
                            color: Colors.red,
                          ),
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
}