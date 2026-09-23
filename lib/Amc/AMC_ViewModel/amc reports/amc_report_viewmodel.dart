import 'package:flutter/material.dart';

import '../../Amc_Model/amc_report_model.dart';
import '../../Service_api/amc_reports/amc_report_service.dart';


class AmcReportViewModel extends ChangeNotifier {
  final AmcReportService _service = AmcReportService();

  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  AmcReportModel? _report;
  AmcReportModel? get report => _report;

  Future<void> fetchReports() async {
    try {
      _loading = true;
      _error = null;
      notifyListeners();

      _report = await _service.getReports();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    await fetchReports();
  }
}