import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/profile/manage Admins/admin_viewmodel.dart';
import 'create admin/create_admin_screen.dart';

class ManageAdminScreen extends StatelessWidget {
  const ManageAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AdminViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Manage Admins")),

      body: Column(
        children: [
          const SizedBox(height: 20),

          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CreateAdminScreen()),
              );
            },

            icon: const Icon(Icons.add),
            label: const Text("Create Admin"),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              itemCount: vm.admins.length,

              itemBuilder: (context, index) {
                final admin = vm.admins[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),

                  child: ListTile(
                    leading: CircleAvatar(child: Text(admin.name[0])),

                    title: Text(admin.name),

                    subtitle: Text(admin.email),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            // Edit Screen
                          },
                        ),

                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            vm.deleteAdmin(admin.id);
                          },
                        ),
                      ],
                    ),
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
