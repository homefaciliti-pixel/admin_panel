import 'package:flutter/material.dart';
import '../../Amc_Model/active_amc_model.dart';
import '../../Service_api/expired/active_amc_service.dart';

class ExpiredAmcViewModel extends ChangeNotifier {
  final ExpiredAmcService _service = ExpiredAmcService();

  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  final List<ActiveAmcModel> _expiredList = [];
  List<ActiveAmcModel> get expiredList => _expiredList;

  List<ActiveAmcModel> _filteredList = [];
  List<ActiveAmcModel> get filteredList => _filteredList;

  String _selectedCategory = "All";
  String get selectedCategory => _selectedCategory;

  Future<void> fetchExpiredAmc() async {
    try {
      _loading = true;
      _error = null;
      notifyListeners();

      _expiredList.clear();

      final data = await _service.fetchExpiredAmc();

      _expiredList.addAll(data);
      _filteredList = List.from(_expiredList);
    } catch (e) {
      _error = e.toString();
      debugPrint("Expired AMC Error : $e");
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void search(String value) {
    if (value.isEmpty) {
      changeCategory(_selectedCategory);
      return;
    }

    _filteredList = _expiredList.where((e) {
      final match =
          e.customerName.toLowerCase().contains(value.toLowerCase()) ||
              e.customerPhone.contains(value) ||
              e.amcId.toLowerCase().contains(value.toLowerCase());

      if (_selectedCategory == "All") {
        return match;
      }

      return match &&
          e.category.toLowerCase() ==
              _selectedCategory.toLowerCase();
    }).toList();

    notifyListeners();
  }

  void changeCategory(String category) {
    _selectedCategory = category;

    if (category == "All") {
      _filteredList = List.from(_expiredList);
    } else {
      _filteredList = _expiredList.where((e) {
        return e.category.toLowerCase() ==
            category.toLowerCase();
      }).toList();
    }

    notifyListeners();
  }

  Future<void> refresh() async {
    await fetchExpiredAmc();
  }
}