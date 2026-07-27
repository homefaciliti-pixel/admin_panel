import 'package:admin_panel/Amc/view/admin_amc_list_view.dart';
import 'package:admin_panel/Amc/view/expired/renew_screen/renew_amc_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../AMC_ViewModel/expired/expired_amc_viewmodel.dart';
import '../../Widget/Amc_card/active_amc_card.dart';
import '../../Widget/common resuse/aap_empty_view.dart';
import '../../Widget/common resuse/app_loading_view.dart';
import '../../Widget/common resuse/app_search_field.dart';

class ExpiredAmcScreen extends StatefulWidget {
  const ExpiredAmcScreen({super.key});

  @override
  State<ExpiredAmcScreen> createState() => _ExpiredAmcScreenState();
}

class _ExpiredAmcScreenState extends State<ExpiredAmcScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExpiredAmcViewModel>().fetchExpiredAmc();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Expired AMC"),
      ),
      backgroundColor: const Color(0xffF5F7FA),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              "Expired AMC",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Manage all expired AMC subscriptions",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            AppSearchField(
              hint: "Search Customer / AMC ID / Phone",
              onChanged: (value) {
                context.read<ExpiredAmcViewModel>().search(value);
              },
            ),

            const SizedBox(height: 20),

            Consumer<ExpiredAmcViewModel>(
              builder: (context, vm, _) {
                return Wrap(
                  spacing: 10,
                  children: [

                    FilterChip(
                      label: const Text("All"),
                      selected: vm.selectedCategory == "All",
                      onSelected: (_) {
                        vm.changeCategory("All");
                      },
                    ),

                    FilterChip(
                      label: const Text("Electrical"),
                      selected: vm.selectedCategory == "Electrical",
                      onSelected: (_) {
                        vm.changeCategory("Electrical");
                      },
                    ),

                    FilterChip(
                      label: const Text("Cleaning"),
                      selected: vm.selectedCategory == "Cleaning",
                      onSelected: (_) {
                        vm.changeCategory("Cleaning");
                      },
                    ),

                    FilterChip(
                      label: const Text("Plumbing"),
                      selected: vm.selectedCategory == "Plumbing",
                      onSelected: (_) {
                        vm.changeCategory("Plumbing");
                      },
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Consumer<ExpiredAmcViewModel>(
                builder: (context, vm, child) {

                  if (vm.loading) {
                    return const AppLoadingView();
                  }

                  if (vm.filteredList.isEmpty) {
                    return const AppEmptyView(
                      title: "No Expired AMC Found",
                      icon: Icons.cancel_outlined,
                    );
                  }

                  if (vm.error != null) {
                    return Center(
                      child: Text(
                        vm.error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: vm.filteredList.length,

                    itemBuilder: (context, index) {

                      final amc = vm.filteredList[index];

                      return ActiveAmcCard(
                        amc: amc,
                        isExpired: true,

                        onView: () {

                        Navigator.push(context, MaterialPageRoute(builder: (_)=> AdminAmcDetailsView(
                          amc:amc,
                          isExpired: true,
                        )));

                        },

                          onRenew: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RenewAmcScreen(
                                  amc: amc,
                                ),
                              ),
                            );
                          }


                      );
                    },
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}