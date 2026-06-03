import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../service_model/settings_model/locality_model.dart';

class LocalityAuth extends ChangeNotifier {
  /// Base API URL
  final String baseUrl =
      'https://adminbackend-1-h03r.onrender.com/api/settings/localities';

  /// All localities from backend
  List<LocalityModel> _allLocalities = [];

  /// Visible list after search
  List<LocalityModel> localities = [];

  bool isLoading = false;
  String? errorMessage;

  /// Pagination
  int selectedEntries = 10;
  int currentPage = 1;

  /// Search text
  String _searchText = '';

  /// Total pages
  int get totalPages {
    if (localities.isEmpty) return 1;
    return (localities.length / selectedEntries).ceil();
  }

  /// Current page data
  List<LocalityModel> get paginatedLocalities {
    final start = (currentPage - 1) * selectedEntries;
    final end = (start + selectedEntries).clamp(0, localities.length);

    if (start >= localities.length) return [];
    return localities.sublist(start, end);
  }

  /// GET /api/settings/localities
  Future<void> fetchLocalities() async {
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
          _allLocalities = data
              .whereType<Map<String, dynamic>>()
              .map((e) => LocalityModel.fromJson(e))
              .toList();

          _applyFilters();
        } else {
          errorMessage = 'Locality data format invalid hai';
        }
      } else {
        errorMessage = decoded['message'] ?? 'Localities load nahi hue';
      }
    } catch (e) {
      errorMessage = 'API error: $e';
    }

    isLoading = false;
    notifyListeners();
  }

  /// Search + pagination apply
  void _applyFilters() {
    List<LocalityModel> result = List.from(_allLocalities);

    if (_searchText.trim().isNotEmpty) {
      final q = _searchText.toLowerCase();
      result = result.where((item) {
        return item.localityName.toLowerCase().contains(q) ||
            item.cityName.toLowerCase().contains(q) ||
            item.stateName.toLowerCase().contains(q);
      }).toList();
    }

    localities = result;

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

  /// Search locality
  void searchLocality(String value) {
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

  /// POST /api/settings/localities
  Future<void> addLocality({
    required String localityName,
    required String cityName,
    required String stateName,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: const {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'localityName': localityName.trim(),
          'cityName': cityName.trim(),
          'stateName': stateName.trim(),
          'status': true,
        }),
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        await fetchLocalities();
      } else {
        errorMessage = decoded['message'] ?? 'Locality add nahi hui';
        notifyListeners();
      }
    } catch (e) {
      errorMessage = 'Add API error: $e';
      notifyListeners();
    }
  }

  /// PUT /api/settings/localities/{id}
  Future<void> updateLocality({
    required int id,
    required String localityName,
    required String cityName,
    required String stateName,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: const {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'localityName': localityName.trim(),
          'cityName': cityName.trim(),
          'stateName': stateName.trim(),
        }),
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        await fetchLocalities();
      } else {
        errorMessage = decoded['message'] ?? 'Locality update nahi hui';
        notifyListeners();
      }
    } catch (e) {
      errorMessage = 'Update API error: $e';
      notifyListeners();
    }
  }

  /// DELETE /api/settings/localities/{id}
  Future<void> deleteLocality(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$id'),
        headers: const {
          'Content-Type': 'application/json',
        },
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 204) {
        await fetchLocalities();
      } else {
        errorMessage = decoded['message'] ?? 'Locality delete nahi hui';
        notifyListeners();
      }
    } catch (e) {
      errorMessage = 'Delete API error: $e';
      notifyListeners();
    }
  }

  /// PATCH /api/settings/localities/{id}/status
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
        final index = _allLocalities.indexWhere((e) => e.id == id);
        if (index != -1) {
          _allLocalities[index] =
              _allLocalities[index].copyWith(status: value);
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