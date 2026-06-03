import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../service_model/settings_model/state_model.dart';

class StateAuth extends ChangeNotifier {
  /// Base API URL
  final String baseUrl =
      'https://adminbackend-1-h03r.onrender.com/api/settings/states';

  /// Full list from backend
  List<StateModel> _allStates = [];

  /// Visible list after search
  List<StateModel> states = [];

  bool isLoading = false;
  String? errorMessage;

  /// Pagination
  int selectedEntries = 10;
  int currentPage = 1;

  /// Search keyword
  String _searchText = '';

  /// Only for dropdowns if needed
  List<StateModel> get allStates => List.from(_allStates);

  /// Total pages
  int get totalPages {
    if (states.isEmpty) return 1;
    return (states.length / selectedEntries).ceil();
  }

  /// Current page data
  List<StateModel> get paginatedStates {
    final start = (currentPage - 1) * selectedEntries;
    final end = (start + selectedEntries).clamp(0, states.length);

    if (start >= states.length) return [];
    return states.sublist(start, end);
  }

  /// GET /api/settings/states
  ///
  Future<void> fetchStates() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: const {
          'Content-Type': 'application/json',
        },
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 &&
          decoded is Map<String, dynamic> &&
          decoded['success'] == true) {
        final data = decoded['data'];

        if (data is List) {
          _allStates = data
              .whereType<Map<String, dynamic>>()
              .map((e) => StateModel.fromJson(e))
              .toList();

          _applyFilters();
        } else {
          errorMessage = 'State data format invalid hai';
        }
      } else {
        errorMessage = decoded['message'] ?? 'States load nahi hue';
      }
    } catch (e) {
      errorMessage = 'API error: $e';
    }

    isLoading = false;
    notifyListeners();
  }

  /// Search + pagination apply
  ///
  void _applyFilters() {
    List<StateModel> result = List.from(_allStates);

    if (_searchText.trim().isNotEmpty) {
      final q = _searchText.toLowerCase();
      result = result.where((item) {
        return item.name.toLowerCase().contains(q);
      }).toList();
    }

    states = result;

    if (currentPage > totalPages) currentPage = totalPages;
    if (currentPage < 1) currentPage = 1;

    notifyListeners();
  }

  /// Change entries per page
  void changeEntries(int value) {
    selectedEntries = value;
    currentPage = 1;
    notifyListeners();
  }

  /// Search state
  void searchState(String value) {
    _searchText = value;
    currentPage = 1;
    _applyFilters();
  }

  /// Next page
  void nextPage() {
    if (currentPage < totalPages) {
      currentPage++;
      notifyListeners();
    }
  }

  /// Previous page
  void previousPage() {
    if (currentPage > 1) {
      currentPage--;
      notifyListeners();
    }
  }

  /// PUT /api/settings/states
  /// You wrote add endpoint as PUT, so using PUT here.
  Future<void> addState({
    required String name,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl), // baseUrl must end with /states
        headers: const {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name.trim(),
          'status': true,
        }),
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        await fetchStates();
      } else {
        errorMessage = decoded['message'] ?? 'State add nahi hui';
        notifyListeners();
      }
    } catch (e) {
      errorMessage = 'Add API error: $e';
      notifyListeners();
    }
  }

  /// PUT /api/settings/states/{id}
  Future<void> updateState({
    required int id,
    required String name,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: const {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name.trim(),
        }),
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        await fetchStates();
      } else {
        errorMessage = decoded['message'] ?? 'State update nahi hui';
        notifyListeners();
      }
    } catch (e) {
      errorMessage = 'Update API error: $e';
      notifyListeners();
    }
  }

  /// DELETE /api/settings/states/{id}
  Future<void> deleteState(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$id'),
        headers: const {
          'Content-Type': 'application/json',
        },
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 204) {
        await fetchStates();
      } else {
        errorMessage = decoded['message'] ?? 'State delete nahi hui';
        notifyListeners();
      }
    } catch (e) {
      errorMessage = 'Delete API error: $e';
      notifyListeners();
    }
  }

  /// PATCH /api/settings/states/{id}/status
  Future<void> toggleStatus(int id, bool value) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/$id/status'),
        headers: const {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'status': value,
        }),
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final index = _allStates.indexWhere((e) => e.id == id);
        if (index != -1) {
          _allStates[index] = _allStates[index].copyWith(status: value);
          _applyFilters();
        }
      } else {
        errorMessage = decoded['message'] ?? 'Status update nahi hua';
        notifyListeners();
      }
    } catch (e) {
      errorMessage = 'Status API error: $e';
      notifyListeners();
    }
  }
}