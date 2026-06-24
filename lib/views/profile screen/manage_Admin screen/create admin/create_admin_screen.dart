import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../service_model/magage_Admin/admin_model.dart';
import '../../../../viewmodels/profile/manage Admins/admin_viewmodel.dart';

class CreateAdminScreen extends StatefulWidget {
  final AdminModel? admin;

  const CreateAdminScreen({super.key, this.admin});

  @override
  State<CreateAdminScreen> createState() => _CreateAdminScreenState();
}

class _CreateAdminScreenState extends State<CreateAdminScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  final Map<String, bool> permissions = {
    "Categories": false,
    "Services": false,
    "Partners": false,
    "Users": false,
    "Bookings": false,
    "Banners": false,
    "Reports": false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Admin")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Admin Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: "Phone Number",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Assign Permissions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            ...permissions.entries.map(
              (item) => CheckboxListTile(
                value: item.value,
                title: Text(item.key),

                onChanged: (value) {
                  setState(() {
                    permissions[item.key] = value!;
                  });
                },
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: () {

                  final vm = Provider.of<AdminViewModel>(
                    context,
                    listen: false,
                  );

                  if (widget.admin == null) {

                    vm.addAdmin(
                      AdminModel(
                        id: DateTime.now().millisecondsSinceEpoch,
                        name: nameController.text,
                        email: emailController.text,
                        role: "Admin",
                        isActive: true,
                      ),
                    );

                  } else {

                    vm.updateAdmin(
                      AdminModel(
                        id: widget.admin!.id,
                        name: nameController.text,
                        email: emailController.text,
                        role: widget.admin!.role,
                        isActive: widget.admin!.isActive,
                      ),
                    );
                  }

                  Navigator.pop(context);
                },

                child: Text(
                  widget.admin == null ? "Create Admin" : "Update Admin",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
