import 'package:flutter/material.dart';

import '../../../service_model/magage_Admin/admin_model.dart';

class AdminViewModel extends ChangeNotifier {
  final List<AdminModel> admins = [
    AdminModel(
      id: 1,
      name: "Amit Sharma",
      email: "amit@gmail.com",
      role: "Admin",
      isActive: true,
    ),

    AdminModel(
      id: 2,
      name: "Rohit Kumar",
      email: "rohit@gmail.com",
      role: "Admin",
      isActive: true,
    ),

    AdminModel(
      id: 3,
      name: "Neha Singh",
      email: "neha@gmail.com",
      role: "Admin",
      isActive: false,
    ),
  ];

  void deleteAdmin(int id) {
    admins.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  void addAdmin(AdminModel admin) {
    admins.add(admin);
    notifyListeners();
  }

  void updateAdmin(AdminModel updatedAdmin) {

    final index = admins.indexWhere(
          (e) => e.id == updatedAdmin.id,
    );

    if (index != -1) {
      admins[index] = updatedAdmin;
      notifyListeners();
    }
  }





}
