import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/profile/manage Admins/admin_viewmodel.dart';
import '../../../widgets/mange admi table/admin_table.dart';
import 'create admin/create_admin_screen.dart';

class ManageAdminScreen extends StatefulWidget {
  const ManageAdminScreen({super.key});

  @override
  State<ManageAdminScreen> createState() => _ManageAdminScreenState();
}

class _ManageAdminScreenState extends State<ManageAdminScreen> {
  final Map<int, bool> _showPassword = {};

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminViewModel>().fetchAdmins();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AdminViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Manage Admins")),

      body: Column(
        children: [
          const SizedBox(height: 20),

          ElevatedButton.icon(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CreateAdminScreen()),
              );

              await vm.fetchAdmins();
            },
            icon: const Icon(Icons.add),
            label: const Text("Create Admin"),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: vm.isLoading
                ? const Center(child: CircularProgressIndicator())
                : AdminTable(admins: vm.admins, vm: vm),
          ),
        ],
      ),
    );
  }
}
