import 'package:flutter/material.dart';
import 'locality_model.dart';
import '../../data/services/api_service.dart';

class LocalityViewModel extends ChangeNotifier {
  final ApiService _api = ApiService();
  bool isLoading = false;

  /// =========================================
  /// PAGINATION
  /// =========================================
  int selectedEntries = 10;
  int currentPage = 1;

  /// =========================================
  /// MASTER LIST
  /// =========================================
  final List<LocalityModel> _allLocalities = [];

  /// visible list
  List<LocalityModel> localities = [];

  /// constructor
  LocalityViewModel() {
    loadLocalities();
  }

  Future<void> loadLocalities() async {
    isLoading = true;
    notifyListeners();

    final list = await _api.getLocalities();
    _allLocalities.clear();
    _allLocalities.addAll(list);
    localities = List.from(_allLocalities);

    isLoading = false;
    notifyListeners();
  }

  /// =========================================
  /// ALL LOCALITIES
  /// =========================================
  List<LocalityModel> get allLocalities => List.from(_allLocalities);

  /// =========================================
  /// TOTAL PAGES
  /// =========================================
  int get totalPages {
    if (localities.isEmpty) return 1;
    return (localities.length / selectedEntries).ceil();
  }

  /// =========================================
  /// PAGINATED DATA
  /// =========================================
  List<LocalityModel> get paginatedLocalities {
    final start = (currentPage - 1) * selectedEntries;
    int end = start + selectedEntries;

    if (end > localities.length) {
      end = localities.length;
    }

    if (start >= localities.length) {
      return [];
    }

    return localities.sublist(start, end);
  }

  /// =========================================
  /// CHANGE ENTRIES
  /// =========================================
  void changeEntries(int value) {
    selectedEntries = value;
    currentPage = 1;
    notifyListeners();
  }

  /// =========================================
  /// NEXT PAGE
  /// =========================================
  void nextPage() {
    if (currentPage < totalPages) {
      currentPage++;
      notifyListeners();
    }
  }

  /// =========================================
  /// PREVIOUS PAGE
  /// =========================================
  void previousPage() {
    if (currentPage > 1) {
      currentPage--;
      notifyListeners();
    }
  }

  /// =========================================
  /// SEARCH LOCALITY
  /// =========================================
  void searchLocality(String value) {
    if (value.trim().isEmpty) {
      localities = List.from(_allLocalities);
    } else {
      final keyword = value.toLowerCase();

      localities = _allLocalities.where((item) {
        return item.localityName.toLowerCase().contains(keyword) ||
            item.cityName.toLowerCase().contains(keyword) ||
            item.stateName.toLowerCase().contains(keyword);
      }).toList();
    }

    currentPage = 1;
    notifyListeners();
  }

  /// =========================================
  /// TOGGLE STATUS
  /// =========================================
  Future<void> toggleStatus(int id) async {
    final index = _allLocalities.indexWhere((e) => e.id == id);
    if (index != -1) {
      final item = _allLocalities[index];
      final updated = await _api.updateLocality(id, status: !item.status);
      if (updated != null) {
        _allLocalities[index] = updated;
        localities = List.from(_allLocalities);
        notifyListeners();
      }
    }
  }

  /// =========================================
  /// ADD LOCALITY
  /// =========================================
  Future<void> addLocality({
    required String localityName,
    required String cityName,
    required String stateName,
  }) async {
    final newLocality = await _api.addLocality(localityName, cityName, stateName, true);
    if (newLocality != null) {
      _allLocalities.add(newLocality);
      localities = List.from(_allLocalities);
      notifyListeners();
    }
  }

  /// =========================================
  /// UPDATE LOCALITY
  /// =========================================
  Future<void> updateLocality({
    required int id,
    required String localityName,
    required String cityName,
    required String stateName,
  }) async {
    final updated = await _api.updateLocality(id, localityName: localityName, cityName: cityName, stateName: stateName);
    if (updated != null) {
      final index = _allLocalities.indexWhere((e) => e.id == id);
      if (index != -1) {
        _allLocalities[index] = updated;
        localities = List.from(_allLocalities);
        notifyListeners();
      }
    }
  }

  /// =========================================
  /// DELETE LOCALITY
  /// =========================================
  Future<void> deleteLocality(int id) async {
    final success = await _api.deleteLocality(id);
    if (success) {
      _allLocalities.removeWhere((e) => e.id == id);
      localities = List.from(_allLocalities);

      if (currentPage > totalPages) {
        currentPage = totalPages;
      }

      notifyListeners();
    }
  }
}