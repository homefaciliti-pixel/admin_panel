import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../service_model/adminlogin_model/admin_login_model.dart';



class AdminAuth extends ChangeNotifier {
  Future<AdminLoginModel?> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await http
          .post(
        Uri.parse(
          "https://adminbackend-1-h03r.onrender.com/api/admins/login",
        ),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "username": username,
          "password": password,
        }),
      )
          .timeout(const Duration(seconds: 15));

      final json = jsonDecode(response.body);

      if (response.statusCode == 200 &&
          json["success"] == true) {
        return AdminLoginModel.fromJson(json["data"]);
      }

      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}