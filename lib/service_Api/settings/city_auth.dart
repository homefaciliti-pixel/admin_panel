import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../service_model/settings_model/city_model.dart';

class CityAuth extends ChangeNotifier {
  /// Base API URL
  final String baseUrl =
      'https://adminbackend-1-h03r.onrender.com/api/settings/cities';

  /// All cities from backend
  List<CityModel> _allCities = [];

  /// Visible city list after search/filter
  List<CityModel> cities = [];
  List<CityModel> get allCities => List.from(_allCities);

  bool isLoading = false;
  String? errorMessage;

  /// Pagination
  int selectedEntries = 10;
  int currentPage = 1;

  /// Search text
  String _searchText = '';

  /// Total pages
  int get totalPages {
    if (cities.isEmpty) return 1;
    return (cities.length / selectedEntries).ceil();
  }

  /// Current page data
  List<CityModel> get paginatedCities {
    final start = (currentPage - 1) * selectedEntries;
    final end = (start + selectedEntries).clamp(0, cities.length);

    if (start >= cities.length) return [];
    return cities.sublist(start, end);
  }

  /// GET /api/settings/cities
  Future<void> fetchCities() async {
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
          _allCities = data
              .whereType<Map<String, dynamic>>()
              .map((e) => CityModel.fromJson(e))
              .toList();

          _applyFilters();
        } else {
          errorMessage = 'City data format invalid hai';
        }
      } else {
        errorMessage = decoded['message'] ?? 'Cities load nahi hue';
      }
    } catch (e) {
      errorMessage = 'API error: $e';
    }

    isLoading = false;
    notifyListeners();
  }

  /// Search + pagination apply
  void _applyFilters() {
    List<CityModel> result = List.from(_allCities);

    if (_searchText.trim().isNotEmpty) {
      final q = _searchText.toLowerCase();
      result = result.where((item) {
        return item.cityName.toLowerCase().contains(q) ||
            item.stateName.toLowerCase().contains(q);
      }).toList();
    }

    cities = result;

    if (currentPage > totalPages) currentPage = totalPages;
    if (currentPage < 1) currentPage = 1;

    notifyListeners();
  }

  /// Change entries count
  void changeEntries(int value) {
    selectedEntries = value;
    currentPage = 1;
    notifyListeners();
  }

  /// Search city
  void searchCity(String value) {
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

  /// POST /api/settings/cities
  Future<void> addCity({
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
          'cityName': cityName.trim(),
          'stateName': stateName.trim(),
          'status': true,
        }),
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        await fetchCities();
      } else {
        errorMessage = decoded['message'] ?? 'City add nahi hui';
        notifyListeners();
      }
    } catch (e) {
      errorMessage = 'Add API error: $e';
      notifyListeners();
    }
  }

  /// PUT /api/settings/cities/{id}
  Future<void> updateCity({
    required int id,
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
          'cityName': cityName.trim(),
          'stateName': stateName.trim(),
        }),
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        await fetchCities();
      } else {
        errorMessage = decoded['message'] ?? 'City update nahi hui';
        notifyListeners();
      }
    } catch (e) {
      errorMessage = 'Update API error: $e';
      notifyListeners();
    }
  }

  /// DELETE /api/settings/cities/{id}
  Future<void> deleteCity(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$id'),
        headers: const {
          'Content-Type': 'application/json',
        },
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 204) {
        await fetchCities();
      } else {
        errorMessage = decoded['message'] ?? 'City delete nahi hui';
        notifyListeners();
      }
    } catch (e) {
      errorMessage = 'Delete API error: $e';
      notifyListeners();
    }
  }

  /// PATCH /api/settings/cities/{id}/status
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
        final index = _allCities.indexWhere((e) => e.id == id);
        if (index != -1) {
          _allCities[index] = _allCities[index].copyWith(status: value);
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