import 'package:flutter/material.dart';
import '../data/models/order_model.dart';
import '../data/services/api_service.dart';

class OrderViewModel extends ChangeNotifier {
  final ApiService _api = ApiService();
  bool isLoading = false;

  /// table me kitni rows dikhani hain
  int selectedEntries = 10;

  /// current page number
  int currentPage = 1;

  /// original list
  final List<OrderModel> _allOrders = [];

  /// screen pe jo orders dikhne hain
  List<OrderModel> orders = [];

  /// constructor
  OrderViewModel() {
    loadOrders();
  }

  Future<void> loadOrders() async {
    isLoading = true;
    notifyListeners();

    final list = await _api.getOrders();
    _allOrders.clear();
    _allOrders.addAll(list);
    orders = List.from(_allOrders);

    isLoading = false;
    notifyListeners();
  }

  /// fetch order details by id
  Future<OrderModel?> getOrderDetails(int id) async {
    return await _api.getOrderById(id);
  }

  /// total pages
  int get totalPages {
    if (orders.isEmpty) return 1;
    return (orders.length / selectedEntries).ceil();
  }

  /// paginated data
  List<OrderModel> get paginatedOrders {
    final start = (currentPage - 1) * selectedEntries;
    int end = start + selectedEntries;

    if (end > orders.length) {
      end = orders.length;
    }

    if (start >= orders.length) {
      return [];
    }

    return orders.sublist(start, end);
  }

  /// change dropdown entries
  void changeEntries(int value) {
    selectedEntries = value;
    currentPage = 1;
    notifyListeners();
  }

  /// next page
  void nextPage() {
    if (currentPage < totalPages) {
      currentPage++;
      notifyListeners();
    }
  }

  /// previous page
  void previousPage() {
    if (currentPage > 1) {
      currentPage--;
      notifyListeners();
    }
  }

  /// search order
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
            item.vendorName.toLowerCase().contains(keyword) ||
            item.status.toLowerCase().contains(keyword);
      }).toList();
    }

    currentPage = 1;
    notifyListeners();
  }

  /// delete order
  Future<void> deleteOrder(int id) async {
    final success = await _api.deleteOrder(id);
    if (success) {
      _allOrders.removeWhere((e) => e.id == id);
      orders = List.from(_allOrders);

      if (currentPage > totalPages) {
        currentPage = totalPages;
      }

      notifyListeners();
    }
  }

  /// assign vendor
  Future<void> assignVendor(int id, String vendorName) async {
    final updated = await _api.assignOrder(id, vendorName);
    if (updated != null) {
      final index = _allOrders.indexWhere((e) => e.id == id);
      if (index != -1) {
        _allOrders[index] = updated;
        orders = List.from(_allOrders);
        notifyListeners();
      }
    }
  }

  /// status update
  Future<void> updateStatus(int id, String status) async {
    final updated = await _api.updateOrder(id, status: status);
    if (updated != null) {
      final index = _allOrders.indexWhere((e) => e.id == id);
      if (index != -1) {
        _allOrders[index] = updated;
        orders = List.from(_allOrders);
        notifyListeners();
      }
    }
  }

  /// unassign vendor
  Future<void> unassignVendor(int id) async {
    final updated = await _api.assignOrder(id, "");
    if (updated != null) {
      final index = _allOrders.indexWhere((e) => e.id == id);
      if (index != -1) {
        _allOrders[index] = updated;
        orders = List.from(_allOrders);
        notifyListeners();
      }
    }
  }

  /// quick stats
  int get totalPendingCount =>
      _allOrders.where((e) => e.status == "Pending").length;

  int get totalAssignedCount =>
      _allOrders.where((e) => e.status == "Assigned").length;

  int get totalCompletedCount =>
      _allOrders.where((e) => e.status == "Completed").length;

  int get totalCancelledCount =>
      _allOrders.where((e) => e.status == "Cancelled").length;
}