import 'package:flutter/material.dart';

import '../../Amc_Model/amc_order_model.dart';
import '../../Service_api/amcorders/amc_order_service.dart';

class AmcOrderViewModel extends ChangeNotifier {
  final AmcOrderService _service = AmcOrderService();

  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  final List<AmcOrderModel> _orderList = [];
  List<AmcOrderModel> get orderList => _orderList;

  List<AmcOrderModel> _filteredList = [];
  List<AmcOrderModel> get filteredList => _filteredList;

  String _selectedStatus = "All";
  String get selectedStatus => _selectedStatus;

  Future<void> fetchOrders() async {
    try {
      _loading = true;
      _error = null;
      notifyListeners();

      _orderList.clear();

      final data = await _service.fetchOrders();

      _orderList.addAll(data);

      _filteredList = List.from(_orderList);
    } catch (e) {
      _error = e.toString();
      debugPrint("AMC Orders Error : $e");
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void search(String value) {
    if (value.isEmpty) {
      changeStatus(_selectedStatus);
      return;
    }

    _filteredList = _orderList.where((e) {
      final match =
          e.amcId.toLowerCase().contains(value.toLowerCase()) ||
          e.serviceName.toLowerCase().contains(value.toLowerCase()) ||
          e.userPhone.contains(value) ||
          (e.partnerName ?? "").toLowerCase().contains(value.toLowerCase());

      if (_selectedStatus == "All") {
        return match;
      }

      return match && e.status.toLowerCase() == _selectedStatus.toLowerCase();
    }).toList();

    notifyListeners();
  }

  void changeStatus(String status) {
    _selectedStatus = status;

    if (status == "All") {
      _filteredList = List.from(_orderList);
    } else {
      _filteredList = _orderList.where((e) {
        return e.status.toLowerCase() == status.toLowerCase();
      }).toList();
    }

    notifyListeners();
  }

  Future<void> refresh() async {
    await fetchOrders();
  }
}
