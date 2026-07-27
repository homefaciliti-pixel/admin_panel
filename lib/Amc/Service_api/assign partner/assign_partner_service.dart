import 'dart:convert';
import 'package:http/http.dart' as http;

class AssignPartnerService {
  static const String _url =
      "https://adminbackend-1-h03r.onrender.com/api/amc/orders/assign-partner";

  Future<bool> assignPartner({
    required int orderId,
    String visitId = "",
    required String partnerName,
    required String partnerPhone,
  }) async {
    final response = await http.post(
      Uri.parse(_url),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "orderId": orderId,
        "visitId": visitId,
        "partnerName": partnerName,
        "partnerPhone": partnerPhone,
      }),
    );

    final json = jsonDecode(response.body);

    if (response.statusCode == 200 && json["success"] == true) {
      return true;
    }

    throw Exception(json["message"] ?? "Partner Assign Failed");
  }
}