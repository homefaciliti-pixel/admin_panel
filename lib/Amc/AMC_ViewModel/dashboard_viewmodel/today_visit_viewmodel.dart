import 'package:flutter/foundation.dart';

import '../../Amc_Model/amc_dashboard/today_visit_model.dart';
import '../../Service_api/Dashboardamc_service/today_visit_service.dart';

class VisitViewModel extends ChangeNotifier {
  final VisitService _service = VisitService();

  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  List<VisitModel> _visits = [];
  List<VisitModel> get visits => _visits;

  List<VisitModel> _filteredList = [];
  List<VisitModel> get filteredList => _filteredList;

  String _selectedStatus = "All";
  String get selectedStatus => _selectedStatus;

  Future<void> fetchVisits() async {
    try {
      _loading = true;
      _error = null;
      notifyListeners();

      _visits = await _service.fetchVisits();

      _filteredList = List.from(_visits);

    } catch (e) {
      _error = e.toString();
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

    _filteredList = _visits.where((e) {

      final match =
          e.serviceName.toLowerCase().contains(value.toLowerCase()) ||

              (e.partnerName ?? "")
                  .toLowerCase()
                  .contains(value.toLowerCase()) ||

              e.amcId.toLowerCase().contains(value.toLowerCase());

      if (_selectedStatus == "All") {
        return match;
      }

      return match &&
          e.status.toLowerCase() ==
              _selectedStatus.toLowerCase();

    }).toList();

    notifyListeners();
  }

  void changeStatus(String status) {

    _selectedStatus = status;

    if (status == "All") {
      _filteredList = List.from(_visits);
    } else {
      _filteredList = _visits.where((e) {
        return e.status.toLowerCase() ==
            status.toLowerCase();
      }).toList();
    }

    notifyListeners();
  }

  Future<void> refresh() async {
    await fetchVisits();
  }
}