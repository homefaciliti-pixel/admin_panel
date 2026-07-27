import 'package:flutter/material.dart';
import '../../Amc_Model/report_model.dart';
import '../../Service_api/reports/report_service.dart';

class AmcReportViewModel extends ChangeNotifier {
  final AmcReportService _service = AmcReportService();

  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  AmcReportModel? _report;
  AmcReportModel? get report => _report;

  Future<void> fetchReport() async {
    try {
      _loading = true;
      _error = null;
      notifyListeners();

      _report = await _service.fetchReport();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    await fetchReport();
  }
}
