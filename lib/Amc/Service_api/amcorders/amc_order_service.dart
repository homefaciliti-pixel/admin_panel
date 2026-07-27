import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Amc_Model/amc_order_model.dart';


class AmcOrderService {
  static const String _baseUrl =
      "https://adminbackend-1-h03r.onrender.com/api/amc/orders";

  Future<List<AmcOrderModel>> fetchOrders() async {
    final response = await http.get(
      Uri.parse(_baseUrl),
    );

    final json = jsonDecode(response.body);

    if (response.statusCode == 200 &&
        json["success"] == true) {
      final List list = json["data"];

      return list
          .map((e) => AmcOrderModel.fromJson(e))
          .toList();
    }

    throw Exception(
      json["message"] ?? "Failed to fetch AMC Orders",
    );
  }
}