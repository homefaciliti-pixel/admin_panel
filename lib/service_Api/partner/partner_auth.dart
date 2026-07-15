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

  bool _approvedLoaded = false;
  bool _pendingLoaded = false;

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
    if (_approvedLoaded && !forceRefresh) {
      partners = List.from(approvedPartners);
      currentPage = 1;
      notifyListeners();
      return;
    }

    await loadAllPartners();

    _approvedLoaded = true;

    partners = List.from(approvedPartners);
    currentPage = 1;
    notifyListeners();
  }

  /// ===============================
  /// PENDING LIST
  /// ===============================
  Future<void> loadPendingPartners({bool forceRefresh = false}) async {
    if (_pendingLoaded && !forceRefresh) {
      partners = List.from(pendingPartners);
      currentPage = 1;
      notifyListeners();
      return;
    }

    await loadAllPartners();

    _pendingLoaded = true;

    partners = List.from(pendingPartners);
    currentPage = 1;
    notifyListeners();
  }

  /// ===============================
  /// SEARCH APPROVED
  /// ===============================
  void searchPartner(String value) {
    if (value.trim().isEmpty) {
      partners = List.from(approvedPartners);
    } else {
      final keyword = value.toLowerCase();
      partners = approvedPartners.where((item) {
        return item.name.toLowerCase().contains(keyword) ||
            item.email.toLowerCase().contains(keyword) ||
            item.mobile.toLowerCase().contains(keyword) ||
            item.city.toLowerCase().contains(keyword) ||
            item.state.toLowerCase().contains(keyword) ||
            item.locality.toLowerCase().contains(keyword);
      }).toList();
    }

    currentPage = 1;
    notifyListeners();
  }

  /// ===============================
  /// SEARCH PENDING
  /// ===============================
  void searchPendingPartner(String value) {
    if (value.trim().isEmpty) {
      partners = List.from(pendingPartners);
    } else {
      final keyword = value.toLowerCase();
      partners = pendingPartners.where((item) {
        return item.name.toLowerCase().contains(keyword) ||
            item.email.toLowerCase().contains(keyword) ||
            item.mobile.toLowerCase().contains(keyword) ||
            item.city.toLowerCase().contains(keyword) ||
            item.state.toLowerCase().contains(keyword) ||
            item.locality.toLowerCase().contains(keyword);
      }).toList();
    }

    currentPage = 1;
    notifyListeners();
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

  Future<String?> _uploadImage(Uint8List bytes, String fieldName) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://adminbackend-1-h03r.onrender.com/api/upload'),
      );
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          bytes,
          filename: '${fieldName}_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ),
      );
      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        if (json['data'] != null && json['data']['url'] != null) {
          return json['data']['url'].toString();
        }
        return json['url']?.toString();
      }
    } catch (e) {
      debugPrint('Error uploading image for $fieldName: $e');
    }
    return null;
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
    debugPrint("🔥🔥 NEW UPDATE FUNCTION RUNNING 🔥🔥");
    debugPrint("UPDATE FIELDS RECEIVED => $updateFields");

    try {
      final Map<String, dynamic> fields = Map.from(updateFields);

      if (profileImageBytes != null && profileImageBytes.isNotEmpty) {
        debugPrint("Uploading profile image...");
        final url = await _uploadImage(profileImageBytes, "profile");
        if (url != null) {
          fields['image'] = url;
        }
      }

      if (aadhaarFrontBytes != null && aadhaarFrontBytes.isNotEmpty) {
        debugPrint("Uploading Aadhaar Front...");
        final url = await _uploadImage(aadhaarFrontBytes, "aadhaar_front");
        if (url != null) {
          fields['aadharFront'] = url;
        }
      }

      if (aadhaarBackBytes != null && aadhaarBackBytes.isNotEmpty) {
        debugPrint("Uploading Aadhaar Back...");
        final url = await _uploadImage(aadhaarBackBytes, "aadhaar_back");
        if (url != null) {
          fields['aadharBack'] = url;
        }
      }

      if (panImageBytes != null && panImageBytes.isNotEmpty) {
        debugPrint("Uploading PAN...");
        final url = await _uploadImage(panImageBytes, "pan");
        if (url != null) {
          fields['panImage'] = url;
        }
      }

      if (policeImageBytes != null && policeImageBytes.isNotEmpty) {
        debugPrint("Uploading Police Image...");
        final url = await _uploadImage(policeImageBytes, "police");
        if (url != null) {
          fields['policeVerificationImage'] = url;
        }
      }

      final response = await http.put(
        Uri.parse('$_baseUrl/partners/$id'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(fields),
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
}
