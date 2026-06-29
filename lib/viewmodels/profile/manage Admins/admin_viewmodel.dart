import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../service_model/magage_Admin/admin_model.dart';

class AdminViewModel extends ChangeNotifier {
  List<AdminModel> admins = [];

  bool isLoading = false;

  /// GET ADMINS
  Future<void> fetchAdmins() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await http.get(
        Uri.parse("https://adminbackend-1-h03r.onrender.com/api/admins"),
      );

      final json = jsonDecode(response.body);

      if (response.statusCode == 200 && json["success"] == true) {
        admins = (json["data"] as List)
            .map((e) => AdminModel.fromJson(e))
            .toList();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// DELETE ADMIN
  Future<void> deleteAdmin(int id) async {
    try {
      final response = await http.delete(
        Uri.parse("https://adminbackend-1-h03r.onrender.com/api/admins/$id"),
      );

      final json = jsonDecode(response.body);

      if (response.statusCode == 200 && json["success"] == true) {
        admins.removeWhere((e) => e.id == id);
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<AdminModel?> createAdmin(String email) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await http.post(
        Uri.parse("https://adminbackend-1-h03r.onrender.com/api/admins"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );

      final json = jsonDecode(response.body);

      if (response.statusCode == 201 && json["success"] == true) {
        final data = json["data"];

        final admin = AdminModel(
          id: 0,
          email: data["email"] ?? "",
          username: data["username"] ?? "",
          password: data["password"] ?? "",
          lastGeneratedAt: "",
          timeRemaining: "24h 0m",
        );

        admins.add(admin);
        notifyListeners();

        return admin;
      }

      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
