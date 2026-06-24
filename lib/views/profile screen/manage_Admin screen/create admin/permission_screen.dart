import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../viewmodels/profile/permission_viewmodel.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PermissionViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Permissions"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Admin Permissions",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [

                ElevatedButton.icon(
                  onPressed: vm.selectAll,
                  icon: const Icon(Icons.done_all),
                  label: const Text("Select All"),
                ),

                const SizedBox(width: 10),

                ElevatedButton.icon(
                  onPressed: vm.unSelectAll,
                  icon: const Icon(Icons.clear),
                  label: const Text("Clear All"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: vm.permissions.length,

                itemBuilder: (context, index) {

                  final key =
                  vm.permissions.keys.elementAt(index);

                  return Card(
                    child: CheckboxListTile(
                      title: Text(key),

                      value: vm.permissions[key],

                      onChanged: (_) {
                        vm.togglePermission(key);
                      },
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed: () {

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Permissions Updated Successfully",
                      ),
                    ),
                  );
                },

                icon: const Icon(Icons.save),

                label: const Text(
                  "Save Permissions",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}