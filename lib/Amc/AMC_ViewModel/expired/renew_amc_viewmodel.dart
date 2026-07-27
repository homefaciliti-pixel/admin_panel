import 'package:flutter/material.dart';
import '../../Service_api/renewamc/renew_api_service.dart';

class RenewAmcViewModel extends ChangeNotifier {
  final RenewAmcService _service = RenewAmcService();

  bool _loading = false;
  bool get loading => _loading;

  String? _message;
  String? get message => _message;

  Future<bool> renewAmc({
    required String amcId,
    required String planId,
    required String note,
    required double price,
    required String durationMonths,
  }) async {

    try {

      _loading = true;
      notifyListeners();

      final data = await _service.renewAmc(
        amcId: amcId,
        planId: planId,
        note: note,
        price: price,
        durationMonths: durationMonths,
      );

      _message =
      "Renewed Successfully\nExpiry : ${data["endDate"]}";

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