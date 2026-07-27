import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Amc_Model/partner_dropdown_model.dart';

class PartnerDropdownService {
  static const String _url =
      "https://adminbackend-1-h03r.onrender.com/api/partners/dropdown";

  Future<List<PartnerDropdownModel>> fetchPartners() async {
    final response = await http.get(Uri.parse(_url));

    final json = jsonDecode(response.body);

    if (response.statusCode == 200 && json["success"] == true) {
      return (json["data"] as List)
          .map((e) => PartnerDropdownModel.fromJson(e))
          .toList();
    }

    throw Exception(json["message"] ?? "Failed to load partners");
  }
}
