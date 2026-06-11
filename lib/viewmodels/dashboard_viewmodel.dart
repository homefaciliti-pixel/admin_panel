import 'package:flutter/material.dart';
import '../data/services/api_service.dart';

class DashboardViewModel extends ChangeNotifier {
  final ApiService _api = ApiService();
  bool isLoading = true;

  int totalUsers = 0;
  int totalCategories = 0;
  int totalServices = 0;
  int totalPartners = 0;
  int totalOrders = 0;
  int todayOrders = 0;
  int completeOrders = 0;
  int assignedOrders = 0;
  int cancelOrders = 0;
  int totalSupporters = 0;

  String subscriptionEarning = "₹0";
  String orderEarning = "₹0";

  DashboardViewModel() {
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    isLoading = true;
    notifyListeners();

    final stats = await _api.getDashboardStats();
    if (stats != null) {
      totalUsers = stats['totalUsers'] ?? 0;
      totalCategories = stats['totalCategories'] ?? 0;
      totalServices = stats['totalServices'] ?? 0;
      totalPartners = stats['totalPartners'] ?? 0;
      totalOrders = stats['totalOrders'] ?? 0;
      todayOrders = stats['todayOrders'] ?? 0;
      completeOrders = stats['completeOrders'] ?? 0;
      assignedOrders = stats['assignedOrders'] ?? 0;
      cancelOrders = stats['cancelOrders'] ?? 0;
      totalSupporters = stats['totalSupporters'] ?? 14;
      subscriptionEarning = stats['subscriptionEarning'] ?? "₹0";
      orderEarning = stats['orderEarning'] ?? "₹0";
    }

    isLoading = false;
    notifyListeners();
  }
}