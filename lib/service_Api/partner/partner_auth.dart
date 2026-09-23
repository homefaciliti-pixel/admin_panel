import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../service_model/partner/partner_model.dart';
/// Partner details screen tabs
enum PartnerDetailTab { detail, additional, kyc, wallet, reviews, bookings }
class PartnerAuth extends ChangeNotifier {
  // country code
  /// BASE URL
  static const String _baseUrl = 'https://adminbackend-1-h03r.onrender.com/api';
  /// ===============================
  /// LIST STATE
  /// ===============================
  final List<PartnerModel> _allPartners = [];
  List<PartnerModel> partners = [];
  bool isLoading = false;
  String? errorMessage;
  /// pagination
  int selectedEntries = 10;
  int currentPage = 1;
  /// selected partner for details screen
  PartnerModel? selectedPartner;
  /// current tab for details screen
  PartnerDetailTab currentTab = PartnerDetailTab.detail;
  /// ===============================
  /// GETTERS
  /// ===============================
  List<PartnerModel> get approvedPartners =>
      _allPartners.where((e) => e.isApproved == true).toList();
  List<PartnerModel> get pendingPartners =>
      _allPartners.where((e) => e.isApproved == false).toList();
  int get totalPages {
    if (partners.isEmpty) return 1;
    return (partners.length / selectedEntries).ceil();
  }
  List<PartnerModel> get paginatedPartners {
    final start = (currentPage - 1) * selectedEntries;
    final end = start + selectedEntries;

    if (start >= partners.length) return [];

    return partners.sublist(
      start,
      end > partners.length ? partners.length : end,
    );
  }
  int get totalApprovedCount => approvedPartners.length;
  int get totalPendingCount => pendingPartners.length;

  /// ===============================
  /// TAB STATE
  /// ===============================
  void changeTab(PartnerDetailTab tab) {
    currentTab = tab;
    notifyListeners();
  }

  /// ===============================
  /// SELECT PARTNER
  /// ===============================
  void selectPartner(PartnerModel partner) {
    selectedPartner = partner;
    notifyListeners();
  }

  void clearSelectedPartner() {
    selectedPartner = null;
    notifyListeners();
  }

  /// ===============================
  /// LOAD ALL PARTNERS
  /// ===============================
  Future<void> loadAllPartners() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final response = await http.get(Uri.parse('$_baseUrl/partners'));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json['success'] == true) {
          final list = json['data'] as List;
          _allPartners
            ..clear()
            ..addAll(list.map((e) => PartnerModel.fromJson(e)).toList());
        } else {
          errorMessage = 'Partner data load nahi hua';
        }
      } else {
        errorMessage = 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// ===============================
  /// APPROVED LIST
  /// ===============================
  Future<void> loadApprovedPartners({bool forceRefresh = false}) async {
    _showingPending = false;

    _searchQuery = '';
    selectedState = null;
    selectedCity = null;
    selectedLocality = null;
    selectedCategory = null;

    await _applyFilters();
  }

  /// ===============================
  /// PENDING LIST
  /// ===============================
  Future<void> loadPendingPartners({bool forceRefresh = false}) async {
    _showingPending = true;

    _searchQuery = '';
    selectedState = null;
    selectedCity = null;
    selectedLocality = null;
    selectedCategory = null;
    selectedPendingDate = 'all';

    // Saare partners backend se lao
    await loadAllPartners();

    // Unme se sirf pending
    partners = List.from(pendingPartners);

    currentPage = 1;

    debugPrint(
      "TOTAL PENDING PARTNERS => ${partners.length}",
    );

    notifyListeners();
  }

  /// ===============================
  /// SEARCH APPROVED
  /// ===============================
  Future<void> searchPendingPartner(String value) async {
    _showingPending = true;
    _searchQuery = value.trim();

    await _applyFilters();
  }

  /// ===============================
  /// PAGINATION
  /// ===============================
  void changeEntries(int value) {
    selectedEntries = value;
    currentPage = 1;
    notifyListeners();
  }

  void nextPage() {
    if (currentPage < totalPages) {
      currentPage++;
      notifyListeners();
    }
  }

  void previousPage() {
    if (currentPage > 1) {
      currentPage--;
      notifyListeners();
    }
  }

  void goToPage(int page) {
    currentPage = page;
    notifyListeners();
  }

  /// ===============================
  /// GET PARTNER DETAILS BY ID
  /// ===============================
  Future<PartnerModel?> getPartnerDetails(int id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/partners/$id'));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['success'] == true) {
          final data = json['data'];
          return PartnerModel.fromJson(data);
        }
      }
    } catch (e) {
      debugPrint('getPartnerDetails error: $e');
    }
    return null;
  }

  /// ===============================
  /// APPROVE PARTNER
  /// ===============================
  Future<bool> approvePartner(int id) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/partners/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'isApproved': true, 'status': true}),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['success'] == true) {
          await loadApprovedPartners(forceRefresh: true);
          return true;
        }
      }
    } catch (e) {
      debugPrint('approvePartner error: $e');
    }
    return false;
  }

  /// ===============================
  /// DISAPPROVE PARTNER
  /// ===============================
  Future<bool> disapprovePartner(int id) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/partners/$id/disapprove'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['success'] == true) {
          await loadPendingPartners(forceRefresh: true);
          return true;
        }
      }
    } catch (e) {
      debugPrint('disapprovePartner error: $e');
    }
    return false;
  }

  /// ===============================
  /// UPDATE PARTNER
  Future<bool> updatePartner(
    int id,
    Map<String, dynamic> updateFields, {
    Uint8List? profileImageBytes,
    Uint8List? aadhaarFrontBytes,
    Uint8List? aadhaarBackBytes,
    Uint8List? panImageBytes,
    Uint8List? policeImageBytes,
  }) async {
    debugPrint(" NEW UPDATE FUNCTION RUNNING ");
    debugPrint("UPDATE FIELDS RECEIVED => $updateFields");

    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/partners/$id'),

        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },

        body: jsonEncode(updateFields),
      );

      debugPrint("UPDATE STATUS = ${response.statusCode}");

      debugPrint("UPDATE BODY = ${response.body}");

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json["success"] == true) {
          final updated = PartnerModel.fromJson(json["data"]);

          final allIndex = _allPartners.indexWhere((e) => e.id == id);

          if (allIndex != -1) {
            _allPartners[allIndex] = updated;
          }

          final partnerIndex = partners.indexWhere((e) => e.id == id);

          if (partnerIndex != -1) {
            partners[partnerIndex] = updated;
          }

          selectedPartner = updated;

          notifyListeners();

          return true;
        }
      }
    } catch (e) {
      debugPrint("updatePartner error $e");
    }

    return false;
  }

  /// ===============================
  /// DELETE PARTNER
  /// ===============================
  Future<bool> deletePartner(int id) async {
    try {
      final response = await http.delete(Uri.parse('$_baseUrl/partners/$id'));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json['success'] == true) {
          _allPartners.removeWhere((e) => e.id == id);
          partners.removeWhere((e) => e.id == id);

          if (selectedPartner != null && selectedPartner!.id == id) {
            selectedPartner = null;
          }

          if (currentPage > totalPages) {
            currentPage = totalPages;
          }

          notifyListeners();
          return true;
        }
      }
    } catch (e) {
      debugPrint('deletePartner error: $e');
    }
    return false;
  }

  /// ===============================
  /// STATUS TOGGLE
  /// ===============================
  Future<bool> updateStatus(int id, bool value) async {
    return updatePartner(id, {'status': value});
  }

  /// ===============================
  /// REFRESH CURRENT VIEW
  /// ===============================
  void refreshCurrentList() {
    if (partners.every((p) => p.isApproved)) {
      partners = List.from(approvedPartners);
    } else {
      partners = List.from(pendingPartners);
    }
    notifyListeners();
  }

  Future<String> changePartnerPassword({
    required int partnerId,
    required String password,
  }) async {
    try {
      final response = await http.put(
        Uri.parse("$_baseUrl/partners/$partnerId/password"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"password": password}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["success"] == true) {
        return data["message"];
      }

      return data["message"] ?? "Failed to change password";
    } catch (e) {
      return e.toString();
    }
  }
// ===============================
// FILTER STATE
// ===============================

  String _searchQuery = '';

  String? selectedState;
  String? selectedCity;
  String? selectedLocality;
  String? selectedCategory;

  String selectedPendingDate = 'all';

  bool _showingPending = false;


// ===============================
// BACKEND FILTER OPTIONS
// ===============================

  List<String> stateOptions = [];
  List<String> cityOptions = [];
  List<String> localityOptions = [];
  List<String> categoryOptions = [];

  bool isFilterLoading = false;

  int get filteredCount => partners.length;

// ===============================
// LOAD FILTER OPTIONS FROM BACKEND
// ===============================

  Future<void> loadFilterOptions() async {
    try {
      isFilterLoading = true;
      notifyListeners();

      final uri = Uri.parse(
        '$_baseUrl/partners/filter-options',
      );

      debugPrint("FILTER OPTIONS API => $uri");

      final response = await http.get(uri);

      debugPrint(
        "FILTER OPTIONS STATUS => ${response.statusCode}",
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json['success'] == true) {
          final data = json['data'];

          categoryOptions = List<String>.from(
            data['categories'] ?? [],
          );

          stateOptions = List<String>.from(
            data['states'] ?? [],
          );

          cityOptions = List<String>.from(
            data['cities'] ?? [],
          );

          localityOptions = List<String>.from(
            data['localities'] ?? [],
          );

          debugPrint(
            "CATEGORIES => ${categoryOptions.length}",
          );

          debugPrint(
            "STATES => ${stateOptions.length}",
          );

          debugPrint(
            "CITIES => ${cityOptions.length}",
          );

          debugPrint(
            "LOCALITIES => ${localityOptions.length}",
          );
        } else {
          debugPrint(
            "Filter API success false => ${json['message']}",
          );
        }
      } else {
        debugPrint(
          "Filter API server error => ${response.statusCode}",
        );
      }
    } catch (e) {
      debugPrint(
        "LOAD FILTER OPTIONS ERROR => $e",
      );
    } finally {
      isFilterLoading = false;
      notifyListeners();
    }
  }
// ===============================
// BACKEND PARTNER FILTER
// ===============================

  Future<void> _applyFilters() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final query = <String, String>{};

      if (_searchQuery.trim().isNotEmpty) {
        query['search'] = _searchQuery.trim();
      }

      if (selectedCategory != null &&
          selectedCategory!.trim().isNotEmpty) {
        query['category'] = selectedCategory!.trim();
      }

      if (selectedState != null &&
          selectedState!.trim().isNotEmpty) {
        query['state'] = selectedState!.trim();
      }

      if (selectedCity != null &&
          selectedCity!.trim().isNotEmpty) {
        query['city'] = selectedCity!.trim();
      }

      if (selectedLocality != null &&
          selectedLocality!.trim().isNotEmpty) {
        query['locality'] = selectedLocality!.trim();
      }
      final uri = Uri.parse(
        _showingPending
            ? '$_baseUrl/partners/pending'
            : '$_baseUrl/partners',
      ).replace(
        queryParameters: query.isEmpty ? null : query,
      );

      debugPrint("PARTNER FILTER API => $uri");

      final response = await http.get(uri);

      debugPrint(
        "PARTNER FILTER STATUS => ${response.statusCode}",
      );

      debugPrint(
        "PARTNER FILTER RESPONSE => ${response.body}",
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json['success'] == true) {
          final data = json['data'];

          if (data is List) {
            partners = data
                .map<PartnerModel>(
                  (e) => PartnerModel.fromJson(e),
            )
                .toList();
          } else {
            partners = [];
            errorMessage = "Invalid partner response";
          }
        } else {
          partners = [];
          errorMessage =
              json['message'] ?? "Partners load nahi hue";
        }
      } else {
        partners = [];
        errorMessage =
        "Server error: ${response.statusCode}";
      }

      currentPage = 1;
    } catch (e) {
      debugPrint("Partner filter error => $e");

      partners = [];
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


// ===============================
// FILTER SETTERS
// ===============================

  Future<void> changeStateFilter(String? value) async {
    selectedState = value;

    // State badla -> City + Locality clear
    selectedCity = null;
    selectedLocality = null;

    await _applyFilters();
  }

  Future<void> changeCityFilter(String? value) async {
    selectedCity = value;

    // City badla -> Locality clear
    selectedLocality = null;

    await _applyFilters();
  }

  Future<void> changeLocalityFilter(String? value) async {
    selectedLocality = value;
    await _applyFilters();
  }

  Future<void> changeCategoryFilter(String? value) async {
    selectedCategory = value;
    await _applyFilters();
  }
  void changePendingDateFilter(String value) {
    selectedPendingDate = value;

    // IMPORTANT:
    // Hamesha original pending list se filter hoga.
    // Approved partner kabhi Pending me nahi aayega.
    List<PartnerModel> filtered = List.from(pendingPartners);

    // ALL selected hai to saare pending dikhao
    if (value == 'all') {
      partners = filtered;
      currentPage = 1;

      debugPrint(
        "PENDING FILTER => ALL | FOUND => ${partners.length}",
      );

      notifyListeners();
      return;
    }

    final now = DateTime.now();

    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );

    filtered = filtered.where((partner) {
      final createdAt = _parsePartnerDate(
        partner.createdAt,
      );

      if (createdAt == null) {
        return false;
      }

      final partnerDate = DateTime(
        createdAt.year,
        createdAt.month,
        createdAt.day,
      );

      switch (value) {
        case 'today':
          return partnerDate == today;

        case 'yesterday':
          final yesterday = today.subtract(
            const Duration(days: 1),
          );

          return partnerDate == yesterday;

        case 'last7':
          final startDate = today.subtract(
            const Duration(days: 6),
          );

          return !partnerDate.isBefore(startDate) &&
              !partnerDate.isAfter(today);

        default:
          return true;
      }
    }).toList();

    partners = filtered;
    currentPage = 1;

    debugPrint(
      "PENDING FILTER => $value | FOUND => ${partners.length}",
    );

    notifyListeners();
  }

// ===============================
// BACKEND SEARCH
// ===============================

  Future<void> searchPartner(String value) async {
    _showingPending = false;
    _searchQuery = value.trim();

    await _applyFilters();
  }


// ===============================
// RESET FILTER
// ===============================

  Future<void> resetFilters() async {
    _searchQuery = '';

    selectedState = null;
    selectedCity = null;
    selectedLocality = null;
    selectedCategory = null;

    selectedPendingDate = 'all';
    currentPage = 1;

    // Pending screen
    if (_showingPending) {
      partners = List.from(pendingPartners);

      debugPrint(
        "RESET PENDING => ${partners.length}",
      );

      notifyListeners();
      return;
    }

    // Approved screen
    await _applyFilters();
  }


// ===============================
// SAFE DATE PARSER
// ===============================
  DateTime? _parsePartnerDate(dynamic value) {
    if (value == null) return null;

    try {
      // Agar already DateTime hai
      if (value is DateTime) {
        return value.toLocal();
      }

      final text = value.toString().trim();

      if (text.isEmpty) {
        return null;
      }

      // ISO backend date
      // Example:
      // 2026-08-04T05:30:00.000Z
      final parsed = DateTime.tryParse(text);

      if (parsed != null) {
        return parsed.toLocal();
      }
    } catch (e) {
      debugPrint(
        "DATE PARSE ERROR => $value | $e",
      );
    }

    return null;
  }
}
