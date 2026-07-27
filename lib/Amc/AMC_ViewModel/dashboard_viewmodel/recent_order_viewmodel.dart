import 'package:flutter/foundation.dart';

import '../../Amc_Model/amc_dashboard/recent_order_model.dart';
import '../../Service_api/Dashboardamc_service/recent_order_service.dart';


class RecentOrderViewModel extends ChangeNotifier {
  final RecentOrderService _service = RecentOrderService();

  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  List<RecentOrderModel> _orders = [];
  List<RecentOrderModel> get orders => _orders;

  Future<void> fetchRecentOrders() async {
    try {
      _loading = true;
      _error = null;
      notifyListeners();

      _orders = await _service.fetchRecentOrders();
    } catch (e) {
      _error = e.toString();
      debugPrint("Recent Orders Error: $e");
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    await fetchRecentOrders();
  }

  void clear() {
    _orders.clear();
    _error = null;
    notifyListeners();
  }
}