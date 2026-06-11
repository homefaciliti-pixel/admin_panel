import 'package:flutter/material.dart';
import '../../data/models/Settings models/state_model.dart';
import '../../data/services/api_service.dart';

class StateViewModel extends ChangeNotifier {
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
  final List<StateModel> _allStates = [];

  /// =========================================
  /// ALL STATES
  /// =========================================
  List<StateModel> get allStates => List.from(_allStates);

  /// visible list
  List<StateModel> states = [];

  /// constructor
  StateViewModel() {
    loadStates();
  }

  Future<void> loadStates() async {
    isLoading = true;
    notifyListeners();

    final list = await _api.getStates();
    _allStates.clear();
    _allStates.addAll(list);
    states = List.from(_allStates);

    isLoading = false;
    notifyListeners();
  }

  /// =========================================
  /// TOTAL PAGES
  /// =========================================
  int get totalPages {
    if (states.isEmpty) return 1;
    return (states.length / selectedEntries).ceil();
  }

  /// =========================================
  /// PAGINATED DATA
  /// =========================================
  List<StateModel> get paginatedStates {
    final start = (currentPage - 1) * selectedEntries;
    int end = start + selectedEntries;

    if (end > states.length) {
      end = states.length;
    }

    if (start >= states.length) {
      return [];
    }

    return states.sublist(start, end);
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
  /// SEARCH
  /// =========================================
  void searchState(String value) {
    if (value.trim().isEmpty) {
      states = List.from(_allStates);
    } else {
      final keyword = value.toLowerCase();
      states = _allStates.where((item) {
        return item.name.toLowerCase().contains(keyword);
      }).toList();
    }
    currentPage = 1;
    notifyListeners();
  }

  /// =========================================
  /// TOGGLE STATUS
  /// =========================================
  Future<void> toggleStatus(int id) async {
    final index = _allStates.indexWhere((e) => e.id == id);
    if (index != -1) {
      final item = _allStates[index];
      final updated = await _api.updateState(id, status: !item.status);
      if (updated != null) {
        _allStates[index] = updated;
        states = List.from(_allStates);
        notifyListeners();
      }
    }
  }

  /// =========================================
  /// ADD STATE
  /// =========================================
  Future<void> addState({
    required String name,
  }) async {
    final newState = await _api.addState(name, true);
    if (newState != null) {
      _allStates.add(newState);
      states = List.from(_allStates);
      notifyListeners();
    }
  }

  /// =========================================
  /// UPDATE STATE
  /// =========================================
  Future<void> updateState({
    required int id,
    required String name,
  }) async {
    final updated = await _api.updateState(id, name: name);
    if (updated != null) {
      final index = _allStates.indexWhere((e) => e.id == id);
      if (index != -1) {
        _allStates[index] = updated;
        states = List.from(_allStates);
        notifyListeners();
      }
    }
  }

  /// =========================================
  /// DELETE STATE
  /// =========================================
  Future<void> deleteState(int id) async {
    final success = await _api.deleteState(id);
    if (success) {
      _allStates.removeWhere((e) => e.id == id);
      states = List.from(_allStates);

      if (currentPage > totalPages) {
        currentPage = totalPages;
      }
      notifyListeners();
    }
  }
}
