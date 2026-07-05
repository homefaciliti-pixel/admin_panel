import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
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

  // today order
  bool showTodayOnly = false;

  /// Advanced Search Filters state
  String _searchText = '';
  String _searchRequestNo = '';
  String _searchId = '';
  String _searchCity = '';
  String _searchLocality = '';
  String _searchVendorNumber = '';
  bool showFilters = false;

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

        _applyFilters();
      } else {
        errorMessage = response.body;
      }
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  /// Compound in-memory filtering logic
  void _applyFilters() {
    List<OrderModel> result = List.from(_allOrders);

    // 1. General search keyword (Name/Request No/City/Locality/Vendor/Address)
    if (_searchText.trim().isNotEmpty) {
      final keyword = _searchText.toLowerCase();
      result = result.where((item) {
        return item.serviceRequestNumber.toLowerCase().contains(keyword) ||
            item.serviceName.toLowerCase().contains(keyword) ||
            item.city.toLowerCase().contains(keyword) ||
            item.locality.toLowerCase().contains(keyword) ||
            item.vendorNumber.toLowerCase().contains(keyword) ||
            item.status.toLowerCase().contains(keyword) ||
            item.address.toLowerCase().contains(keyword);
      }).toList();
    }

    // 2. Service Request No filter
    if (_searchRequestNo.trim().isNotEmpty) {
      final q = _searchRequestNo.trim().toLowerCase();
      result = result.where((item) {
        return item.serviceRequestNumber.toLowerCase().contains(q);
      }).toList();
    }

    // 3. ID Filter
    if (_searchId.trim().isNotEmpty) {
      final q = _searchId.trim();
      result = result.where((item) {
        return item.id.toString().contains(q);
      }).toList();
    }

    // 4. City Filter
    if (_searchCity.trim().isNotEmpty) {
      final q = _searchCity.trim().toLowerCase();
      result = result.where((item) {
        return item.city.toLowerCase().contains(q);
      }).toList();
    }

    // 5. Locality Filter
    if (_searchLocality.trim().isNotEmpty) {
      final q = _searchLocality.trim().toLowerCase();
      result = result.where((item) {
        return item.locality.toLowerCase().contains(q);
      }).toList();
    }

    // 6. Vendor Number Filter
    if (_searchVendorNumber.trim().isNotEmpty) {
      final q = _searchVendorNumber.trim().toLowerCase();
      result = result.where((item) {
        return item.vendorNumber.toLowerCase().contains(q) ||
            item.vendorMobile.toLowerCase().contains(q);
      }).toList();
    }

    orders = result;

    if (currentPage > totalPages) {
      currentPage = totalPages;
    }
    if (currentPage < 1) {
      currentPage = 1;
    }

    notifyListeners();
  }

  /// Toggle filters panel visibility
  void toggleFilters() {
    showFilters = !showFilters;
    notifyListeners();
  }

  /// Clear all active filters
  void clearAllFilters() {
    _searchText = '';
    _searchRequestNo = '';
    _searchId = '';
    _searchCity = '';
    _searchLocality = '';
    _searchVendorNumber = '';
    currentPage = 1;
    _applyFilters();
  }

  /// Main search query updated
  void searchOrder(String value) {
    _searchText = value;
    currentPage = 1;
    _applyFilters();
  }

  /// Filter by Service Request No
  void searchByRequestNo(String value) {
    _searchRequestNo = value;
    currentPage = 1;
    _applyFilters();
  }

  /// Filter by ID
  void searchById(String value) {
    _searchId = value;
    currentPage = 1;
    _applyFilters();
  }

  /// Filter by City
  void searchByCity(String value) {
    _searchCity = value;
    currentPage = 1;
    _applyFilters();
  }

  /// Filter by Locality
  void searchByLocality(String value) {
    _searchLocality = value;
    currentPage = 1;
    _applyFilters();
  }

  /// Filter by Vendor Number
  void searchByVendorNumber(String value) {
    _searchVendorNumber = value;
    currentPage = 1;
    _applyFilters();
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

  Future<bool> assignVendor(
    int id,
    String vendorNumber,
    String vendorName,
  ) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final body = {
        'vendorMobile': vendorNumber.trim(),
        'vendorName': vendorName,
      };

      final response = await http.put(
        Uri.parse('$_baseUrl/$id/assign'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
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
    return assignVendor(id, '', '');
  }

  Future<bool> updateStatus(int id, String status) async {
    return updateOrder(id, {'status': status});
  }

  Future<void> openMap(double lat, double lng) async {
    final url = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$lat,$lng",
    );

    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  //Today orders

  void filterTodayOrders() {
    showTodayOnly = !showTodayOnly;

    if (showTodayOnly) {
      final now = DateTime.now();

      final today =
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

      orders = _allOrders.where((order) {
        return order.serviceDate == today;
      }).toList();
    } else {
      orders = List.from(_allOrders);
    }

    currentPage = 1;

    notifyListeners();
  }
}
