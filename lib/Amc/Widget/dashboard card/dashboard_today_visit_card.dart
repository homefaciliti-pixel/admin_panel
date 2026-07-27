import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../AMC_ViewModel/dashboard_viewmodel/today_visit_viewmodel.dart';
import '../../view/visitHistoryScreen/visit_details_screen.dart';
import '../../view/visitHistoryScreen/visit_history_screen.dart';
import '../VisitHistoryCard/visit_history_card.dart';
import '../amcsimmer/amc_simmer.dart';
import 'dashboard_section_title.dart';

class DashboardTodayVisits extends StatefulWidget {
  const DashboardTodayVisits({super.key});

  @override
  State<DashboardTodayVisits> createState() =>
      _DashboardTodayVisitsState();
}

class _DashboardTodayVisitsState
    extends State<DashboardTodayVisits> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VisitViewModel>().fetchVisits();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VisitViewModel>(
      builder: (context, vm, child) {

        if (vm.loading) {
          return const DashboardAmcShimmer();
        }

        if (vm.error != null) {
          return Center(
            child: Text(vm.error!),
          );
        }

        /// Today's Visits Filter
        final today = DateTime.now();

        final todayVisits = vm.visits.where((visit) {
          final date = DateTime.tryParse(visit.scheduledDate);

          if (date == null) return false;

          return date.year == today.year &&
              date.month == today.month &&
              date.day == today.day;
        }).toList();

        /// Sirf top 5 dikhayenge Dashboard par
        final displayVisits = todayVisits.take(5).toList();

        if (displayVisits.isEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const DashboardSectionTitle(
                title: "Today's Visits",
                icon: Icons.calendar_today,
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    "No Today's Visits",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                const Expanded(
                  child: DashboardSectionTitle(
                    title: "Today's Visits",
                    icon: Icons.calendar_today,
                  ),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const VisitHistoryScreen(),
                      ),
                    );
                  },
                  child: const Text("View All"),
                ),
              ],
            ),

            const SizedBox(height: 18),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: displayVisits.length,
              itemBuilder: (context, index) {

                final visit = displayVisits[index];

                return VisitCard(
                  visit: visit,

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VisitDetailsScreen(
                          visit: visit,
                        ),
                      ),
                    );
                  },


                );
              },
            ),
          ],
        );
      },
    );
  }
}