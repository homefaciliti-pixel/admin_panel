import 'package:flutter/material.dart';
import '../../Amc_Model/partner_payment_model.dart';

class PartnerPaymentViewModel extends ChangeNotifier {

  bool _loading = false;
  bool get loading => _loading;

  final List<PartnerPaymentModel> _paymentList = [];
  List<PartnerPaymentModel> get paymentList => _paymentList;

  List<PartnerPaymentModel> _filteredList = [];
  List<PartnerPaymentModel> get filteredList => _filteredList;

  String _selectedStatus = "All";
  String get selectedStatus => _selectedStatus;

  Future<void> fetchPayments() async {

    _loading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _paymentList.clear();

    _paymentList.addAll([

      const PartnerPaymentModel(
        paymentId: "PAY001",
        partnerId: "P001",
        partnerName: "Rahul Sharma",
        partnerPhone: "9876543210",
        orderId: "ORD1001",
        amcId: "AMC001",
        totalOrders: 12,
        serviceAmount: 6000,
        commission: 1500,
        payableAmount: 4500,
        paymentMethod: "Bank Transfer",
        transactionId: "",
        paymentDate: "20 Jul 2026",
        status: "Pending",
      ),

      const PartnerPaymentModel(
        paymentId: "PAY002",
        partnerId: "P002",
        partnerName: "Mohit Kumar",
        partnerPhone: "9876500000",
        orderId: "ORD1002",
        amcId: "AMC002",
        totalOrders: 8,
        serviceAmount: 4200,
        commission: 1050,
        payableAmount: 3150,
        paymentMethod: "UPI",
        transactionId: "TXN102545",
        paymentDate: "18 Jul 2026",
        status: "Paid",
      ),

      const PartnerPaymentModel(
        paymentId: "PAY003",
        partnerId: "P003",
        partnerName: "Aman Verma",
        partnerPhone: "9988776655",
        orderId: "ORD1003",
        amcId: "AMC003",
        totalOrders: 15,
        serviceAmount: 7500,
        commission: 1875,
        payableAmount: 5625,
        paymentMethod: "Bank Transfer",
        transactionId: "",
        paymentDate: "22 Jul 2026",
        status: "Processing",
      ),

      const PartnerPaymentModel(
        paymentId: "PAY004",
        partnerId: "P004",
        partnerName: "Deepak Singh",
        partnerPhone: "9871234567",
        orderId: "ORD1004",
        amcId: "AMC004",
        totalOrders: 10,
        serviceAmount: 5000,
        commission: 1250,
        payableAmount: 3750,
        paymentMethod: "Bank Transfer",
        transactionId: "",
        paymentDate: "23 Jul 2026",
        status: "Failed",
      ),

    ]);

    _filteredList = List.from(_paymentList);

    _loading = false;
    notifyListeners();
  }

  void search(String value) {

    if (value.isEmpty) {
      changeStatus(_selectedStatus);
      return;
    }

    _filteredList = _paymentList.where((e) {

      final match =

          e.partnerName
              .toLowerCase()
              .contains(value.toLowerCase()) ||

              e.partnerPhone.contains(value) ||

              e.paymentId
                  .toLowerCase()
                  .contains(value.toLowerCase()) ||

              e.orderId
                  .toLowerCase()
                  .contains(value.toLowerCase()) ||

              e.amcId
                  .toLowerCase()
                  .contains(value.toLowerCase());

      if (_selectedStatus == "All") {
        return match;
      }

      return match && e.status == _selectedStatus;

    }).toList();

    notifyListeners();
  }

  void changeStatus(String status) {

    _selectedStatus = status;

    if (status == "All") {

      _filteredList = List.from(_paymentList);

    } else {

      _filteredList = _paymentList
          .where((e) => e.status == status)
          .toList();
    }

    notifyListeners();
  }

  Future<void> markAsPaid(
      String paymentId,
      String transactionId,
      ) async {

    final index = _paymentList.indexWhere(
          (e) => e.paymentId == paymentId,
    );

    if (index == -1) return;

    final payment = _paymentList[index];

    _paymentList[index] = PartnerPaymentModel(
      paymentId: payment.paymentId,
      partnerId: payment.partnerId,
      partnerName: payment.partnerName,
      partnerPhone: payment.partnerPhone,
      orderId: payment.orderId,
      amcId: payment.amcId,
      totalOrders: payment.totalOrders,
      serviceAmount: payment.serviceAmount,
      commission: payment.commission,
      payableAmount: payment.payableAmount,
      paymentMethod: payment.paymentMethod,
      transactionId: transactionId,
      paymentDate: payment.paymentDate,
      status: "Paid",
    );

    changeStatus(_selectedStatus);
  }

  Future<void> refresh() async {
    await fetchPayments();
  }

  void clearFilter() {
    _selectedStatus = "All";
    _filteredList = List.from(_paymentList);
    notifyListeners();
  }

  double get totalPendingAmount {
    return _paymentList
        .where((e) => e.status == "Pending")
        .fold(0.0, (sum, e) => sum + e.payableAmount);
  }

  double get totalPaidAmount {
    return _paymentList
        .where((e) => e.status == "Paid")
        .fold(0.0, (sum, e) => sum + e.payableAmount);
  }

  int get totalPartners {
    return _paymentList.length;
  }

  int get totalPayments {
    return _paymentList.length;
  }

}