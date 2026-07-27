import 'package:flutter/material.dart';

import '../../Amc_Model/active_amc_model.dart';
import '../../Service_api/activeamc/ActiveAmcService.dart';

class ActiveAmcViewModel extends ChangeNotifier {
  final ActiveAmcService _service = ActiveAmcService();

  //======================
  // Loading
  //======================

  bool _loading = false;
  bool get loading => _loading;

  //======================
  // Error
  //======================

  String? _error;
  String? get error => _error;

  //======================
  // Active AMC List
  //======================

  final List<ActiveAmcModel> _activeAmcList = [];
  List<ActiveAmcModel> get activeAmcList => _activeAmcList;

  List<ActiveAmcModel> _filteredList = [];
  List<ActiveAmcModel> get filteredList => _filteredList;

  //======================
  // Filter
  //======================

  String _selectedCategory = "All";
  String get selectedCategory => _selectedCategory;

  //======================
  // Assign Partner
  //======================

  bool autoAssign = true;

  String? selectedService;
  String? selectedPartner;

  DateTime? selectedDate;
  String? selectedTime;

  String priority = "Normal";

  final TextEditingController instructionController =
  TextEditingController();

  //======================
  // Fetch Active AMC
  //======================

  Future<void> fetchActiveAmc() async {
    try {
      _loading = true;
      _error = null;
      notifyListeners();

      _activeAmcList.clear();

      final data = await _service.fetchActiveAmc();

      _activeAmcList.addAll(data);

      _filteredList = List.from(_activeAmcList);
    } catch (e) {
      _error = e.toString();
      debugPrint("Active AMC Error: $e");
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  //======================
  // Search
  //======================

  void search(String value) {
    if (value.isEmpty) {
      changeCategory(_selectedCategory);
      return;
    }

    _filteredList = _activeAmcList.where((e) {
      final match =
          e.customerName.toLowerCase().contains(value.toLowerCase()) ||
              e.customerPhone.contains(value) ||
              e.amcId.toLowerCase().contains(value.toLowerCase()) ||
              e.category.toLowerCase().contains(value.toLowerCase());

      if (_selectedCategory == "All") {
        return match;
      }

      return match &&
          e.category.toLowerCase() ==
              _selectedCategory.toLowerCase();
    }).toList();

    notifyListeners();
  }

  //======================
  // Category Filter
  //======================

  void changeCategory(String category) {
    _selectedCategory = category;

    if (category == "All") {
      _filteredList = List.from(_activeAmcList);
    } else {
      _filteredList = _activeAmcList.where((e) {
        return e.category.toLowerCase() ==
            category.toLowerCase();
      }).toList();
    }

    notifyListeners();
  }

  //======================
  // Refresh
  //======================

  Future<void> refresh() async {
    await fetchActiveAmc();
  }

  //======================
  // Auto Assign
  //======================

  void changeAutoAssign(bool value) {
    autoAssign = value;

    if (value) {
      selectedPartner = null;
    }

    notifyListeners();
  }

  //======================
  // Dispose
  //======================

  @override
  void dispose() {
    instructionController.dispose();
    super.dispose();
  }
}