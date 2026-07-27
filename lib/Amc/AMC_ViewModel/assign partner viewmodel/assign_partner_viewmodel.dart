import 'package:flutter/material.dart';

import '../../Amc_Model/partner_dropdown_model.dart';
import '../../Service_api/assign partner/assign_partner_service.dart';
 
import '../../Service_api/partnerdropdown _service/partner_dropdown_service.dart';

class AssignPartnerViewModel extends ChangeNotifier {
  final PartnerDropdownService _partnerService =
  PartnerDropdownService();

  final AssignPartnerService _assignService =
  AssignPartnerService();

  bool _loading = false;
  bool get loading => _loading;

  String? _message;
  String? get message => _message;

  List<PartnerDropdownModel> _partners = [];
  List<PartnerDropdownModel> get partners => _partners;

  PartnerDropdownModel? _selectedPartner;
  PartnerDropdownModel? get selectedPartner =>
      _selectedPartner;

  Future<void> fetchPartners() async {
    try {
      _loading = true;
      notifyListeners();

      _partners =
      await _partnerService.fetchPartners();

    } catch (e) {
      _message = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void selectPartner(PartnerDropdownModel partner) {
    _selectedPartner = partner;
    notifyListeners();
  }

  Future<bool> assignPartner(int orderId) async {
    if (_selectedPartner == null) {
      _message = "Please select partner";
      return false;
    }

    try {
      _loading = true;
      notifyListeners();

      await _assignService.assignPartner(
        orderId: orderId,
        partnerName: _selectedPartner!.name,
        partnerPhone: _selectedPartner!.mobile,
      );

      _message = "Partner assigned successfully";

      return true;

    } catch (e) {
      _message = e.toString();
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}