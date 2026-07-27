import 'package:flutter/material.dart';

 import '../../Amc_Model/amc_dashboard/dashboard_model.dart';
import '../../Service_api/Dashboardamc_service/dashboard_service.dart';

class DashboardAmcViewModel extends ChangeNotifier {
  final DashboardService _service = DashboardService();

  bool _loading = false;
  bool get loading => _loading;

  DashboardAmcModel? _dashboard;
  DashboardAmcModel? get dashboard => _dashboard;

  String? _error;
  String? get error => _error;

  Future<void> fetchDashboard() async {
    try {
      _loading = true;
      _error = null;
      notifyListeners();

      _dashboard = await _service.fetchDashboard();
    } catch (e) {
      _error = e.toString();
      debugPrint("Dashboard Error: $e");
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

}