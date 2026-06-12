import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../service_Api/Activepartners/active_partner_auth.dart';
import '../../widgets/partner/active_partner/active_partner_table.dart';

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

            // TITLE

            const Text(
              "Active Partners",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // SEARCH

            Container(
              height: 50,

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(12),
              ),

              child: TextField(
                controller: searchController,

                decoration: const InputDecoration(
                  hintText:
                  "Search Partner...",
                  prefixIcon:
                  Icon(Icons.search),
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // TABLE

            Expanded(
              child: vm.isLoading
                  ? const Center(
                child:
                CircularProgressIndicator(),
              )
                  : ActivePartnerTable(
                partners: vm.partners,
                vm: vm,
              ),
            ),

            const SizedBox(height: 15),

            // PAGINATION (dummy)

            Row(
              mainAxisAlignment:
              MainAxisAlignment.end,

              children: [

                OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    "Previous",
                  ),
                ),

                const SizedBox(width: 10),

                Container(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius:
                    BorderRadius.circular(
                      8,
                    ),
                  ),

                  child: const Text(
                    "1",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    "Next",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}