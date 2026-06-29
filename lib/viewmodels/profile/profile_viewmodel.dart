import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service_model/Profile/profile_model.dart';

class ProfileViewModel extends ChangeNotifier {
  ProfileModel profile = ProfileModel(
    name: "",
    email: "",
    role: "",
    company: "HomeFaciliti",
    image: "",
    totalAdmins: 5,
    revenue: "₹2,45,000",
  );

  Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();

    final role = prefs.getString("role") ?? "admin";

    profile = ProfileModel(
      name: prefs.getString("name") ?? "Admin",
      email: prefs.getString("email") ?? "",
      role: role == "super_admin" ? "Super Admin" : "Admin",
      company: "HomeFaciliti",
      image: "",
      totalAdmins: 5,
      revenue: "₹2,45,000",
    );

    notifyListeners();
  }
}
