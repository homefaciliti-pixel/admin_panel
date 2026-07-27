import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Amc_Model/amc_dashboard/dashboard_model.dart';

class DashboardService {
  static const String _url =
      "https://adminbackend-1-h03r.onrender.com/api/amc/dashboard";

  Future<DashboardAmcModel> fetchDashboard() async {
    final response = await http.get(Uri.parse(_url));

    final json = jsonDecode(response.body);

    if (response.statusCode == 200 && json["success"] == true) {
      return DashboardAmcModel.fromJson(json["data"]);
    }

    throw Exception(json["message"] ?? "Failed to load dashboard");
  }
}