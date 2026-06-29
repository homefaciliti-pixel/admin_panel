import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../service_model/magage_Admin/admin_model.dart';
import '../../viewmodels/profile/manage Admins/admin_viewmodel.dart';

class AdminTable extends StatefulWidget {
  final List<AdminModel> admins;
  final AdminViewModel vm;

  const AdminTable({super.key, required this.admins, required this.vm});

  @override
  State<AdminTable> createState() => _AdminTableState();
}

class _AdminTableState extends State<AdminTable> {
  final Map<int, bool> _showPassword = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          /// HEADER
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
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
                  child: Text("#", style: TextStyle(color: Colors.white)),
                ),

                Expanded(
                  flex: 2,
                  child: Text(
                    "Username",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                Expanded(
                  flex: 3,
                  child: Text("Email", style: TextStyle(color: Colors.white)),
                ),

                Expanded(
                  flex: 3,
                  child: Text(
                    "Password",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Text(
                    "Time Left",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: Text("Delete", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),

          /// BODY
          Expanded(
            child: ListView.builder(
              itemCount: widget.admins.length,
              itemBuilder: (context, index) {
                final admin = widget.admins[index];

                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                  child: Row(
                    children: [
                      /// SERIAL
                      Expanded(flex: 1, child: Text("${index + 1}")),

                      /// USERNAME
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.blue.shade50,
                              child: Text(admin.username[0].toUpperCase()),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: Text(
                                admin.username,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// EMAIL
                      Expanded(flex: 3, child: Text(admin.email)),

                      /// PASSWORD
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                _showPassword[admin.id] == true
                                    ? admin.password
                                    : "••••••••••",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            IconButton(
                              splashRadius: 20,
                              icon: Icon(
                                _showPassword[admin.id] == true
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _showPassword[admin.id] =
                                      !(_showPassword[admin.id] ?? false);
                                });
                              },
                            ),

                            IconButton(
                              splashRadius: 20,
                              icon: const Icon(Icons.copy),
                              onPressed: () async {
                                await Clipboard.setData(
                                  ClipboardData(text: admin.password),
                                );

                                if (!mounted) return;

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text("Password Copied"),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      /// TIME REMAINING
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            admin.timeRemaining,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.green.shade800,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),

                      /// DELETE
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text("Delete Admin"),
                                content: Text(
                                  "Are you sure you want to delete ${admin.username}?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text("Cancel"),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                    ),
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: const Text("Delete"),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              await widget.vm.deleteAdmin(admin.id);

                              if (!mounted) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text("Admin deleted successfully"),
                                ),
                              );
                            }
                          },
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
