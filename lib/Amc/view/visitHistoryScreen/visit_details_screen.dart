import 'package:admin_panel/Amc/Amc_Model/amc_dashboard/today_visit_model.dart';
import 'package:flutter/material.dart';

 import '../../Widget/VisitHistoryCard/visit details screen card/visit_header_card.dart';
import '../../Widget/VisitHistoryCard/visit details screen card/visit_images_card.dart';
import '../../Widget/VisitHistoryCard/visit details screen card/visit_notes_card.dart';
import '../../Widget/VisitHistoryCard/visit details screen card/visit_partner_card.dart';
import '../../Widget/VisitHistoryCard/visit details screen card/visit_service_card.dart';



class VisitDetailsScreen extends StatelessWidget {

  final VisitModel visit;

  const VisitDetailsScreen({
    super.key,
    required this.visit,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        title: const Text("Visit Details"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            VisitHeaderCard(
              visit: visit,
            ),

            const SizedBox(height: 20),

            VisitServiceCard(
              visit: visit,
            ),

            const SizedBox(height: 20),

            VisitPartnerCard(
              visit: visit,
            ),

            const SizedBox(height: 20),

            VisitNotesCard(
              visit: visit,
            ),

            const SizedBox(height: 20),

            VisitImagesCard(
              visit: visit,
            ),

          ],
        ),
      ),
    );
  }
}