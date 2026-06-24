import 'package:flutter/material.dart';
import '../../service_model/Profile/profile_model.dart';

class ProfileViewModel extends ChangeNotifier {
  ProfileModel profile = ProfileModel(
    name: "Hira Yadav",
    email: "superadmin@homefaciliti.com",
    role: "Super Admin",
    company: "HomeFaciliti",
    image: "",
    totalAdmins: 5,
    revenue: "₹2,45,000",
  );
}
