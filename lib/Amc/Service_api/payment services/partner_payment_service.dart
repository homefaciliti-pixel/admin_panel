import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../Amc_Model/partner_payment_model.dart';

class PartnerPaymentService {
  static const String _baseUrl =
      "https://adminbackend-1-h03r.onrender.com/api/amc";

  Future<List<PartnerPaymentModel>> fetchPayments() async {
    final response = await http.get(
      Uri.parse("$_baseUrl/partner-payments"),
    );

    final json = jsonDecode(response.body);

    if (response.statusCode == 200 && json["success"] == true) {
      return (json["data"] as List)
          .map((e) => PartnerPaymentModel.fromJson(e))
          .toList();
    }

    throw Exception(json["message"] ?? "Failed to fetch payments");
  }

  
}