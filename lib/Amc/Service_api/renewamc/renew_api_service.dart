import 'dart:convert';
import 'package:http/http.dart' as http;

class RenewAmcService {
  static const String _baseUrl =
      "https://adminbackend-1-h03r.onrender.com/api/amc";

  Future<Map<String, dynamic>> renewAmc({
    required String amcId,
    required String planId,
    required String note,
    required double price,
    required String durationMonths,
  }) async {

    final response = await http.post(
      Uri.parse("$_baseUrl/$amcId/renew"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "planId": planId,
        "note": note,
        "price": price.toString(),
        "durationMonths": durationMonths,
      }),
    );



    final json = jsonDecode(response.body);

    if (response.statusCode == 200 &&
        json["success"] == true) {
      return json["data"];
    }

    throw Exception(json["message"]);
  }
}