import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../Amc_Model/amc_dashboard/today_visit_model.dart';


class VisitService {
  static const String _url =
      "https://adminbackend-1-h03r.onrender.com/api/amc/visits";

  Future<List<VisitModel>> fetchVisits() async {
    try {
      final response = await http.get(
        Uri.parse(_url),
      );

      final json = jsonDecode(response.body);

      if (response.statusCode == 200 &&
          json["success"] == true) {
        final List list = json["data"] ?? [];

        return list
            .map((e) => VisitModel.fromJson(e))
            .toList();
      }

      throw Exception(
        json["message"] ?? "Failed to fetch visits",
      );
    } catch (e) {
      throw Exception("Visit Error : $e");
    }
  }
}