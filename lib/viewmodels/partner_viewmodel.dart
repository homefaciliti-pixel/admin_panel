import 'package:flutter/material.dart';
import '../data/models/partner_model.dart';
import '../data/services/api_service.dart';

/// partner details screen ke tabs
enum PartnerDetailTab {
  detail,
  additional,
  kyc,
  wallet,
  reviews,
  bookings,
}

class PartnerViewModel extends ChangeNotifier {
  final ApiService _api = ApiService();
  bool isLoading = false;

  /// kitni entries show karni hai
  int selectedEntries = 10;

  /// current active page
  int currentPage = 1;

  /// master full list
  final List<PartnerModel> _allPartners = [];

  /// current screen pe jo list dikh rahi hai
  List<PartnerModel> partners = [];

  PartnerViewModel() {
    loadPartners();
  }

  Future<void> loadPartners() async {
    isLoading = true;
    notifyListeners();

    final list = await _api.getPartners();
    _allPartners.clear();
    _allPartners.addAll(list);
    partners = List.from(_allPartners);

    isLoading = false;
    notifyListeners();
  }

  /// total pages
  int get totalPages {
    if (partners.isEmpty) return 1;
    return (partners.length / selectedEntries).ceil();
  }

  /// approved partners list
  List<PartnerModel> get approvedPartners {
    return _allPartners.where((e) => e.isApproved).toList();
  }

  /// pending partners list
  List<PartnerModel> get pendingPartners {
    return _allPartners.where((e) => !e.isApproved).toList();
  }

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

  void searchPartner(String value) {
    if (value.trim().isEmpty) {
      partners = List.from(_allPartners);
    } else {
      final keyword = value.toLowerCase();

      partners = _allPartners.where((item) {
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

  /// active / inactive toggle (ID-based - paginated index safe)
  Future<void> toggleStatus(int index, bool value) async {
    final partner = partners[index];
    final success = await _api.togglePartnerStatus(partner.id, value);
    if (success) {
      partners[index].status = value;
      final mainIndex = _allPartners.indexWhere((e) => e.id == partner.id);
      if (mainIndex != -1) {
        _allPartners[mainIndex].status = value;
      }
      notifyListeners();
    }
  }

  /// toggle by partner ID directly
  Future<void> toggleStatusById(int id, bool value) async {
    final success = await _api.togglePartnerStatus(id, value);
    if (success) {
      final index = partners.indexWhere((e) => e.id == id);
      if (index != -1) partners[index].status = value;
      final mainIndex = _allPartners.indexWhere((e) => e.id == id);
      if (mainIndex != -1) _allPartners[mainIndex].status = value;
      notifyListeners();
    }
  }

  /// approve partnerTable
  Future<void> approvePartner(int id) async {
    final updated = await _api.updatePartner(id, {'isApproved': true, 'status': true});
    if (updated != null) {
      final index = _allPartners.indexWhere((e) => e.id == id);
      if (index != -1) {
        _allPartners[index] = updated;
        partners = List.from(_allPartners);
        notifyListeners();
      }
    }
  }

  /// disapprove partner
  Future<void> disapprovePartner(int id) async {
    final updated = await _api.updatePartner(id, {'isApproved': true, 'status': false});
    if (updated != null) {
      final index = _allPartners.indexWhere((e) => e.id == id);
      if (index != -1) {
        _allPartners[index] = updated;
        partners = List.from(_allPartners);
        notifyListeners();
      }
    }
  }

  PartnerModel? selectedPartner;

  /// details screen ke liye selected partner set
  void selectPartner(PartnerModel partner) {
    selectedPartner = partner;
    currentTab = PartnerDetailTab.detail;
    notifyListeners();
  }

  void clearSelectedPartner() {
    selectedPartner = null;
    notifyListeners();
  }

  PartnerDetailTab currentTab = PartnerDetailTab.detail;

  void changeTab(PartnerDetailTab tab) {
    currentTab = tab;
    notifyListeners();
  }

  /// update partner
  Future<void> updatePartner(PartnerModel updatedPartner) async {
    final Map<String, dynamic> updateFields = {
      'name': updatedPartner.name,
      'email': updatedPartner.email,
      'mobile': updatedPartner.mobile,
      'city': updatedPartner.city,
      'state': updatedPartner.state,
      'locality': updatedPartner.locality,
      'address': updatedPartner.address,
      'image': updatedPartner.image,
      'gender': updatedPartner.gender,
      'experience': updatedPartner.experience,
      'services': updatedPartner.services,
      'aadhaarNumber': updatedPartner.aadhaarNumber,
      'panNumber': updatedPartner.panNumber,
      'bankName': updatedPartner.bankName,
      'accountNumber': updatedPartner.accountNumber,
      'ifscCode': updatedPartner.ifscCode,
      'documents': updatedPartner.documents,
      'status': updatedPartner.status,
      'isApproved': updatedPartner.isApproved,
    };
    final updated = await _api.updatePartner(updatedPartner.id, updateFields);
    if (updated != null) {
      final index = _allPartners.indexWhere((e) => e.id == updatedPartner.id);
      if (index != -1) {
        _allPartners[index] = updated;
        partners = List.from(_allPartners);
        notifyListeners();
      }
    }
  }

  /// delete partner
  Future<void> deletePartner(int id) async {
    final success = await _api.deletePartner(id);
    if (success) {
      _allPartners.removeWhere((e) => e.id == id);
      partners = List.from(_allPartners);

      if (currentPage > totalPages) {
        currentPage = totalPages;
      }
      notifyListeners();
    }
  }

  /// quick stats
  int get totalApprovedCount => approvedPartners.length;
  int get totalPendingCount => pendingPartners.length;

  /// approved list load karne ke liye
  void loadApprovedPartners() {
    partners = List.from(approvedPartners);
    currentPage = 1;
    notifyListeners();
  }

  /// pending list load karne ke liye
  void loadPendingPartners() {
    partners = List.from(pendingPartners);
    currentPage = 1;
    notifyListeners();
  }

  /// pending search
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
}

