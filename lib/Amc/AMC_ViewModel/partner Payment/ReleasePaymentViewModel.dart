import 'package:flutter/material.dart';
import '../../Service_api/payment services/payment_payout.dart';


class ReleasePaymentViewModel extends ChangeNotifier {
  final ReleasePaymentService _service = ReleasePaymentService();

  bool _loading = false;
  bool get loading => _loading;

  String _message = "";
  String get message => _message;

  Future<bool> releasePayment(int paymentId) async {
    try {
      _loading = true;
      _message = "";
      notifyListeners();

      _message = await _service.releasePayment(paymentId);

      return true;
    } catch (e) {
      _message = e.toString();
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }


  void clearMessage() {
    _message = "";
    notifyListeners();
  }
}