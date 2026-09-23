import 'package:flutter/material.dart';

import '../../Amc_Model/partner_payment_model.dart';
import '../../Service_api/payment services/partner_payment_service.dart';

class PartnerPaymentViewModel extends ChangeNotifier {
  final PartnerPaymentService _service = PartnerPaymentService();

  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  List<PartnerPaymentModel> _payments = [];
  List<PartnerPaymentModel> get payments => _payments;

  List<PartnerPaymentModel> _filteredPayments = [];
  List<PartnerPaymentModel> get filteredPayments => _filteredPayments;

  String _selectedStatus = "All";
  String get selectedStatus => _selectedStatus;

  /// =========================
  /// Fetch Payments
  /// =========================
  Future<void> fetchPayments() async {
    try {
      _loading = true;
      _error = null;
      notifyListeners();

      _payments = await _service.fetchPayments();

      _applyFilters();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// =========================
  /// Search
  /// =========================
  void search(String value) {
    final query = value.trim().toLowerCase();

    List<PartnerPaymentModel> list = _payments;

    if (_selectedStatus != "All") {
      list = list
          .where((e) =>
      e.status.toLowerCase() ==
          _selectedStatus.toLowerCase())
          .toList();
    }

    if (query.isNotEmpty) {
      list = list.where((e) {
        return e.partnerName.toLowerCase().contains(query) ||
            e.partnerPhone.contains(query) ||
            e.amcId.toLowerCase().contains(query);
      }).toList();
    }

    _filteredPayments = list;

    notifyListeners();
  }

  /// =========================
  /// Status Filter
  /// =========================
  void changeStatus(String status) {
    _selectedStatus = status;

    _applyFilters();

    notifyListeners();
  }

  /// =========================
  /// Refresh
  /// =========================
  Future<void> refresh() async {
    await fetchPayments();
  }

  /// =========================
  /// Internal Filter
  /// =========================
  void _applyFilters() {
    if (_selectedStatus == "All") {
      _filteredPayments = List.from(_payments);
    } else {
      _filteredPayments = _payments.where((e) {
        return e.status.toLowerCase() ==
            _selectedStatus.toLowerCase();
      }).toList();
    }
  }

  /// =========================
  /// Pending Count
  /// =========================
  int get pendingCount =>
      _payments.where((e) => e.status == "pending").length;

  /// =========================
  /// Released Count
  /// =========================
  int get releasedCount =>
      _payments.where((e) => e.status == "released").length;

  /// =========================
  /// Total Amount
  /// =========================
  double get totalAmount =>
      _payments.fold(0.0, (sum, item) => sum + item.amount);

  /// =========================
  /// Pending Amount
  /// =========================
  double get pendingAmount => _payments
      .where((e) => e.status == "pending")
      .fold(0.0, (sum, item) => sum + item.amount);

  int get totalPayments => _payments.length;

  int get totalPartners =>
      _payments
          .map((e) => e.partnerPhone)
          .toSet()
          .length;




  /// =========================
  /// Released Amount
  /// =========================
  double get releasedAmount => _payments
      .where((e) => e.status == "released")
      .fold(0.0, (sum, item) => sum + item.amount);
}