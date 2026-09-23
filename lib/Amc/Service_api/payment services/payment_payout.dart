import 'dart:convert';

import 'package:http/http.dart' as http;

class ReleasePaymentService {
  static const String _baseUrl =
      "https://adminbackend-1-h03r.onrender.com/api/amc";

  Future<String> releasePayment(int paymentId) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/partner-payments/release"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "paymentId": paymentId,
      }),
    );

    final json = jsonDecode(response.body);

    if (response.statusCode == 200 && json["success"] == true) {
      return json["message"];
    }

    throw Exception(json["message"] ?? "Payment release failed");
  }
}