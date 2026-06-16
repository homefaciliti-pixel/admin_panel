import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../service_model/Active_Partners_model/active_partner_model.dart';

class ActivePartnerAuth extends ChangeNotifier {
  bool isLoading = false;

  List<ActivePartnerModel> partners = [];

  Future<void> getActivePartners() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await http.get(
        Uri.parse(
          "https://adminbackend-1-h03r.onrender.com/api/partners/active",
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        partners = (data["data"] as List)
            .map((e) => ActivePartnerModel.fromJson(e))
            .toList();
      }
    } catch (e) {
      debugPrint("Active Partner Error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
