import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../Amc_Model/amc_dashboard/recent_order_model.dart';


class RecentOrderService {
  static const String _baseUrl =
      "https://adminbackend-1-h03r.onrender.com/api/amc/dashboard/recent-orders";

  Future<List<RecentOrderModel>> fetchRecentOrders() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {
          "Content-Type": "application/json",
        },
      );

      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 200 &&
          jsonData["success"] == true) {

        final List list = jsonData["data"] ?? [];

        return list
            .map((e) => RecentOrderModel.fromJson(e))
            .toList();
      }

      throw Exception(
        jsonData["message"] ?? "Failed to fetch recent orders",
      );
    } catch (e) {
      throw Exception("Recent Order Error : $e");
    }
  }
}