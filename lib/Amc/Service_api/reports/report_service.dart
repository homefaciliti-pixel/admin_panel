import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Amc_Model/report_model.dart';

class AmcReportService {
  static const String _url =
      "https://adminbackend-1-h03r.onrender.com/api/amc/reports";

  Future<AmcReportModel> fetchReport() async {
    final response = await http.get(Uri.parse(_url));

    final json = jsonDecode(response.body);

    if (response.statusCode == 200 && json["success"] == true) {
      return AmcReportModel.fromJson(json["data"]);
    }

    throw Exception(json["message"] ?? "Failed to load report");
  }
}
