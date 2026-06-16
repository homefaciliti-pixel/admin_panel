import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../service_model/order/order_model.dart';

class OrderAuth extends ChangeNotifier {
  OrderAuth() {
    orders = List.from(_allOrders);
  }

  static const String _baseUrl =
      'https://adminbackend-1-h03r.onrender.com/api/orders';

  bool isLoading = false;
  String? errorMessage;

  int selectedEntries = 10;
  int currentPage = 1;

  final List<OrderModel> _allOrders = [];
  List<OrderModel> orders = [];

  int get totalPages {
    if (orders.isEmpty) return 1;
    return (orders.length / selectedEntries).ceil();
  }

  List<OrderModel> get paginatedOrders {
    final start = (currentPage - 1) * selectedEntries;
    int end = start + selectedEntries;

    if (start >= orders.length) return [];

    if (end > orders.length) {
      end = orders.length;
    }

    return orders.sublist(start, end);
  }

  void changeEntries(int value) {
    selectedEntries = value;
    currentPage = 1;
    notifyListeners();
  }

  void nextPage() {
    if (currentPage < totalPages) {
      currentPage++;
      notifyListeners();
    }
  }

  void previousPage() {
    if (currentPage > 1) {
      currentPage--;
      notifyListeners();
    }
  }

  Future<void> fetchOrders() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        final List<dynamic> dataList = decoded is Map<String, dynamic>
            ? (decoded['data'] as List<dynamic>? ?? <dynamic>[])
            : <dynamic>[];

        _allOrders
          ..clear()
          ..addAll(
            dataList.map((e) => OrderModel.fromJson(e as Map<String, dynamic>)),
          );

        orders = List.from(_allOrders);

        if (currentPage > totalPages) {
          currentPage = totalPages;
        }
      } else {
        errorMessage = response.body;
      }
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  void searchOrder(String value) {
    if (value.trim().isEmpty) {
      orders = List.from(_allOrders);
    } else {
      final keyword = value.toLowerCase();
      orders = _allOrders.where((item) {
        return item.serviceRequestNumber.toLowerCase().contains(keyword) ||
            item.serviceName.toLowerCase().contains(keyword) ||
            item.city.toLowerCase().contains(keyword) ||
            item.locality.toLowerCase().contains(keyword) ||
            item.vendorNumber.toLowerCase().contains(keyword) ||
            item.status.toLowerCase().contains(keyword) ||
            item.address.toLowerCase().contains(keyword);
      }).toList();
    }

    currentPage = 1;
    notifyListeners();
  }

  Future<bool> updateOrder(int id, Map<String, dynamic> updateFields) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updateFields),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['success'] == true) {
          await fetchOrders();
          return true;
        }
      }

      errorMessage = response.body;
      return false;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }






  Future<bool> assignVendor(int id, String vendorNumber) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/$id/assign'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'vendorMobile': vendorNumber.trim(),
        }),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json['success'] == true) {
          await fetchOrders();
          return true;
        }
      }

      errorMessage = response.body;
      return false;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> unassignVendor(int id) async {
    return assignVendor(id, '');
  }

  Future<bool> updateStatus(int id, String status) async {
    return updateOrder(id, {'status': status});
  }
}
