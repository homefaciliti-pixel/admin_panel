import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DashboardViewModel extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;

  /// API se aane wali cards list
  List<Map<String, dynamic>> cards = [];

  Future<void> fetchDashboard() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('https://adminbackend-1-h03r.onrender.com/api/dashboard'),
        headers: const {
          'Content-Type': 'application/json',
        },
      );

      debugPrint("DASHBOARD STATUS => ${response.statusCode}");
      debugPrint("DASHBOARD BODY => ${response.body}");

      final decoded = jsonDecode(response.body);

      if (decoded is Map<String, dynamic> && decoded['success'] == true) {
        final data = decoded['data'];

        if (data is List) {
          cards = data.whereType<Map<String, dynamic>>().toList();
        } else {
          errorMessage = 'Dashboard data list me nahi hai';
        }
      } else {
        errorMessage = 'Dashboard response invalid hai';
      }
    } catch (e) {
      errorMessage = 'API error: $e';
    }

    isLoading = false;
    notifyListeners();
  }

  int _amountByName(String name) {
    final item = cards.cast<Map<String, dynamic>?>().firstWhere(
          (e) => (e?['name']?.toString() ?? '') == name,
      orElse: () => null,
    );

    return item?['totalAmount'] ?? 0;
  }

  int get totalUsers => _amountByName('Total Users');
  int get totalCategories => _amountByName('Total Categories');
  int get totalServices => _amountByName('Total Services');
  int get totalPartners => _amountByName('Total Partners');
  int get totalOrders => _amountByName('Total Orders');
  int get todayOrders => _amountByName('Today Orders');
  int get completeOrders => _amountByName('Complete Orders');
  int get assignedOrders => _amountByName('Assigned Orders');
  int get cancelOrders => _amountByName('Cancel Orders');
  int get totalSupporters => _amountByName('Total Supporters');

  String get subscriptionEarning =>
      '₹${_amountByName('Subscription Earnings')}';

  String get orderEarning =>
      '₹${_amountByName('Order Earnings')}';
}