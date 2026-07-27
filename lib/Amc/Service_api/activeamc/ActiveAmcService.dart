import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../Amc_Model/active_amc_model.dart';


class ActiveAmcService {

  static const String url =
      "https://adminbackend-1-h03r.onrender.com/api/amc/active";

  Future<List<ActiveAmcModel>> fetchActiveAmc() async {

    final response = await http.get(Uri.parse(url));

    final json = jsonDecode(response.body);

    if (response.statusCode == 200 &&
        json["success"] == true) {

      return (json["data"] as List)
          .map((e) => ActiveAmcModel.fromJson(e))
          .toList();
    }

    throw Exception(json["message"]);
  }
}