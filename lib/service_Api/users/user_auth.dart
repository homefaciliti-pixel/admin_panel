import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../service_model/Users_model/user_model.dart';

class UserViewmodel extends ChangeNotifier {
  /// Full user list from API
  List<UserModel> _allUsers = [];

  /// Filtered list after search
  List<UserModel> filteredUsers = [];

  /// Selected user for details popup
  UserModel? selectedUser;

  bool isLoading = false;
  String? errorMessage;

  /// Pagination
  int currentPage = 1;
  int selectedEntries = 10;

  /// Search texts
  String _searchText = '';
  String _searchId = '';
  String _searchMobile = '';
  String _searchCity = '';
  String _searchState = '';
  bool showFilters = false;

  /// Total pages count
  int get totalPages {
    if (filteredUsers.isEmpty) return 1;
    return (filteredUsers.length / selectedEntries).ceil();
  }

  /// Current page users
  List<UserModel> get paginatedUsers {
    final start = (currentPage - 1) * selectedEntries;
    final end = (start + selectedEntries).clamp(0, filteredUsers.length);

    if (start >= filteredUsers.length) return [];
    return filteredUsers.sublist(start, end);
  }

  /// Fetch users from backend
  Future<void> fetchUsers() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('https://adminbackend-1-h03r.onrender.com/api/users'),
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
          _allUsers = data
              .whereType<Map<String, dynamic>>()
              .map((e) => UserModel.fromJson(e))
              .toList();

          _applyFilters();
        } else {
          errorMessage = 'Users data format invalid hai';
        }
      } else {
        errorMessage = decoded['message'] ?? 'Users load nahi ho paye';
      }
    } catch (e) {
      errorMessage = 'API error: $e';
    }

    isLoading = false;
    notifyListeners();
  }

  /// Apply search filters + pagination reset
  void _applyFilters() {
    List<UserModel> result = List.from(_allUsers);

    // 1. Keyword search (Name/Email/Address)
    if (_searchText.trim().isNotEmpty) {
      final q = _searchText.toLowerCase();
      result = result.where((user) {
        return user.name.toLowerCase().contains(q) ||
            user.email.toLowerCase().contains(q) ||
            user.address.toLowerCase().contains(q);
      }).toList();
    }

    // 2. ID Filter
    if (_searchId.trim().isNotEmpty) {
      final q = _searchId.trim();
      result = result.where((user) {
        return user.id.toString().contains(q);
      }).toList();
    }

    // 3. Mobile Filter
    if (_searchMobile.trim().isNotEmpty) {
      final q = _searchMobile.trim().toLowerCase();
      result = result.where((user) {
        return user.mobile.toLowerCase().contains(q);
      }).toList();
    }

    // 4. City Filter
    if (_searchCity.trim().isNotEmpty) {
      final q = _searchCity.trim().toLowerCase();
      result = result.where((user) {
        return user.city.toLowerCase().contains(q) ||
            user.address.toLowerCase().contains(q);
      }).toList();
    }

    // 5. State Filter
    if (_searchState.trim().isNotEmpty) {
      final q = _searchState.trim().toLowerCase();
      result = result.where((user) {
        return user.state.toLowerCase().contains(q) ||
            user.address.toLowerCase().contains(q);
      }).toList();
    }

    filteredUsers = result;

    if (currentPage > totalPages) {
      currentPage = totalPages;
    }
    if (currentPage < 1) {
      currentPage = 1;
    }

    notifyListeners();
  }

  /// Toggle filters view
  void toggleFilters() {
    showFilters = !showFilters;
    notifyListeners();
  }

  /// Clear all filters
  void clearAllFilters() {
    _searchText = '';
    _searchId = '';
    _searchMobile = '';
    _searchCity = '';
    _searchState = '';
    currentPage = 1;
    _applyFilters();
  }

  /// Search users by name/email keyword
  void searchUser(String value) {
    _searchText = value;
    currentPage = 1;
    _applyFilters();
  }

  /// Search by ID
  void searchById(String value) {
    _searchId = value;
    currentPage = 1;
    _applyFilters();
  }

  /// Search by Mobile
  void searchByMobile(String value) {
    _searchMobile = value;
    currentPage = 1;
    _applyFilters();
  }

  /// Search by City
  void searchByCity(String value) {
    _searchCity = value;
    currentPage = 1;
    _applyFilters();
  }

  /// Search by State
  void searchByState(String value) {
    _searchState = value;
    currentPage = 1;
    _applyFilters();
  }

  /// Change entries per page
  void changeEntries(int value) {
    selectedEntries = value;
    currentPage = 1;
    notifyListeners();
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

  /// Fetch single user details
  Future<void> fetchUserDetails(int id) async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://adminbackend-1-h03r.onrender.com/api/users/$id',
        ),
        headers: const {
          'Content-Type': 'application/json',
        },
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 &&
          decoded is Map<String, dynamic> &&
          decoded['success'] == true) {
        final data = decoded['data'];

        if (data is Map<String, dynamic>) {
          selectedUser = UserModel.fromJson(data);
          notifyListeners();
        } else {
          errorMessage = 'User details format invalid hai';
          notifyListeners();
        }
      } else {
        errorMessage = decoded['message'] ?? 'User details load nahi hui';
        notifyListeners();
      }
    } catch (e) {
      errorMessage = 'USER DETAILS ERROR: $e';
      notifyListeners();
    }
  }

  /// Clear selected user after closing dialog
  void clearSelectedUser() {
    selectedUser = null;
    notifyListeners();
  }

  /// Delete user from backend and list
  Future<void> deleteUser(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('https://adminbackend-1-h03r.onrender.com/api/users/$id'),
        headers: const {
          'Content-Type': 'application/json',
        },
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 &&
          decoded is Map<String, dynamic> &&
          decoded['success'] == true) {
        _allUsers.removeWhere((user) => user.id == id);
        _applyFilters();
      } else {
        errorMessage = decoded['message'] ?? 'Delete failed';
        notifyListeners();
      }
    } catch (e) {
      errorMessage = 'Delete API error: $e';
      notifyListeners();
    }
  }
}