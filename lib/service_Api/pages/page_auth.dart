import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../service_model/pages/page_model.dart';

class PageAuth extends ChangeNotifier {

  final String baseUrl =
      'https://adminbackend-1-h03r.onrender.com/api';

  List<PageModel> pages = [];

  bool isLoading = false;
  String? errorMessage;

  /// ==========================
  /// GET PAGES
  /// ==========================

  Future<void> fetchPages() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/pages'),
      );

      final decoded =
      jsonDecode(response.body);

      if (response.statusCode == 200 &&
          decoded['success'] == true) {
        final data = decoded['data'];

        pages = (data as List)
            .map(
              (e) => PageModel.fromJson(e),
        )
            .toList();
      } else {
        errorMessage =
            decoded['message'] ??
                'Pages load nahi hue';
      }
    } catch (e) {
      errorMessage =
      'API Error : $e';
    }

    isLoading = false;
    notifyListeners();
  }

  /// ==========================
  /// UPDATE PAGE
  /// ==========================

  Future<void> updatePage({
    required int id,
    required String title,
    required String description,
  }) async {

    try {
      final response = await http.put(
        Uri.parse(
          '$baseUrl/pages/$id',
        ),

        headers: {
          'Content-Type':
          'application/json',
        },

        body: jsonEncode({
          "title": title,
          "description": description,
        }),
      );

      final decoded =
      jsonDecode(response.body);

      if (response.statusCode == 200 &&
          decoded['success'] == true) {

        final index =
        pages.indexWhere(
              (e) => e.id == id,
        );

        if (index != -1) {
          pages[index] =
              pages[index].copyWith(
                title: title,
                description:
                description,
              );

          notifyListeners();
        }
      } else {
        errorMessage =
        decoded['message'];
        notifyListeners();
      }
    } catch (e) {
      errorMessage =
      'Update Error : $e';

      notifyListeners();
    }
  }
}