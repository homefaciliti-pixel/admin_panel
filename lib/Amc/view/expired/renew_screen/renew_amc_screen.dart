import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../AMC_ViewModel/expired/renew_amc_viewmodel.dart';
import '../../../Amc_Model/active_amc_model.dart';
import '../../../Widget/book_service/customer_info_card.dart';
import '../../../Widget/common resuse/app_section_title.dart';

import '../../../Widget/expired/renew_plan_card.dart';

class RenewAmcScreen extends StatefulWidget {
  final ActiveAmcModel amc;

   const RenewAmcScreen({
    super.key,
    required this.amc,
  });

  @override
  State<RenewAmcScreen> createState() => _RenewAmcScreenState();
}

class _RenewAmcScreenState extends State<RenewAmcScreen> {
  final TextEditingController noteController =
  TextEditingController();

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),

          title: const Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              SizedBox(width: 10),
              Text("Success"),
            ],
          ),

          content: const Text(
            "AMC renewed successfully.",
          ),

          actions: [

            FilledButton(
              onPressed: () {

                Navigator.pop(context);

                Navigator.pop(context);

              },
              child: const Text("OK"),
            )

          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        title: const Text("Renew AMC"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Customer
            CustomerInfoCard(
              amc: widget.amc,
              title: "Customer Information",
              showStatus: true,
            ),

            const SizedBox(height: 20),

            /// Plan
            const AppSectionTitle(
              title: "AMC Plan",
            ),

            const SizedBox(height: 15),

            RenewPlanCard(
              amc: widget.amc,
            ),





            const SizedBox(height: 20),

            /// Notes
            const AppSectionTitle(
              title: "Notes",
            ),

            const SizedBox(height: 15),

            TextFormField(
              controller: noteController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Enter renewal note...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child:FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                onPressed: () {
                  _showRenewDialog(context);
                },
                icon: const Icon(Icons.refresh),
                label: const Text("Renew AMC"),
              )
            ),

          ],
        ),
      ),
    );
  }

  Future<void> _showRenewDialog(BuildContext context)async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),

          title: const Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.orange,
              ),
              SizedBox(width: 10),
              Text("Confirm Renewal"),
            ],
          ),

          content: const Text(
            "Are you sure you want to renew this AMC subscription?\n\n"
                "This will activate the AMC for another 365 days.",
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Cancel"),
            ),

            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Renew"),
            ),

          ],
        );
      },
    );

    if(confirm == true) {
      _renewAmc(context);
    }
  }

  Future<void> _renewAmc(BuildContext context) async {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    final vm = context.read<RenewAmcViewModel>();

    final success = await vm.renewAmc(
      amcId: widget.amc.amcId,
      planId: widget.amc.category,      // electrician
      note: noteController.text.trim(),
      price: widget.amc.price,
      durationMonths: "12months",
    );

    if (context.mounted) {
      Navigator.pop(context); // Loading Dialog
    }

    if (!context.mounted) return;

    if (success) {
      _showSuccessDialog(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(vm.message ?? "Renew failed"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }


}