import 'package:flutter/material.dart';

import '../data/models/booking_earning_model.dart';
import '../data/models/subscription_earning_model.dart';

/// earnings screen ke tabs
enum EarningsTab {
  bookings,
  subscriptions,
}

class EarningsViewModel extends ChangeNotifier {
  /// =========================================
  /// TAB STATE
  /// =========================================

  /// currently selected tab
  EarningsTab currentTab = EarningsTab.bookings;

  /// tab change karne ke liye
  void changeTab(EarningsTab tab) {
    currentTab = tab;
    notifyListeners();
  }

  /// =========================================
  /// BOOKING EARNINGS DATA
  /// =========================================

  final List<BookingEarningModel> _allBookingEarnings = [
    BookingEarningModel(
      id: 1,
      transactionId: "TXN1001",
      serviceAmount: 500.0,
      paymentMethod: "UPI",
      extraServiceAmount: 100.0,
      extraServicePaymentMethod: "Cash",
      totalAmount: 600.0,
      orderDate: "11-05-2026",
    ),
    BookingEarningModel(
      id: 2,
      transactionId: "TXN1002",
      serviceAmount: 800.0,
      paymentMethod: "Cash",
      extraServiceAmount: 0.0,
      extraServicePaymentMethod: "-",
      totalAmount: 800.0,
      orderDate: "10-05-2026",
    ),
    BookingEarningModel(
      id: 3,
      transactionId: "TXN1003",
      serviceAmount: 1200.0,
      paymentMethod: "Card",
      extraServiceAmount: 200.0,
      extraServicePaymentMethod: "UPI",
      totalAmount: 1400.0,
      orderDate: "09-05-2026",
    ),
  ];

  /// visible booking earnings list
  List<BookingEarningModel> bookingEarnings = [];

  /// =========================================
  /// SUBSCRIPTION EARNINGS DATA
  /// =========================================

  final List<SubscriptionEarningModel> _allSubscriptionEarnings = [
    SubscriptionEarningModel(
      id: 1,
      partnerName: "Govind",
      amount: 100.0,

      status: "Paid", paymentMethod: 'Upi', purchaseDate: '12-05-2026',
    ),
    SubscriptionEarningModel(
      id: 2,

      partnerName: "Mahesh Kumar",
      amount: 100.0,

      status: "Paid", paymentMethod: 'UPI', purchaseDate: '13-05-2026',
    ),
  ];



  /// visible subscription earnings list
  List<SubscriptionEarningModel> subscriptionEarnings = [];

  /// =========================================
  /// SEARCH
  /// =========================================

  /// search text
  String searchText = "";

  /// constructor
  EarningsViewModel() {
    bookingEarnings = List.from(_allBookingEarnings);
    subscriptionEarnings = List.from(_allSubscriptionEarnings);
  }

  /// booking search
  void searchBookings(String value) {
    searchText = value.trim();

    if (searchText.isEmpty) {
      bookingEarnings = List.from(_allBookingEarnings);
    } else {
      final keyword = searchText.toLowerCase();

      bookingEarnings = _allBookingEarnings.where((item) {
        return item.transactionId.toLowerCase().contains(keyword) ||
            item.paymentMethod.toLowerCase().contains(keyword) ||
            item.extraServicePaymentMethod.toLowerCase().contains(keyword) ||
            item.orderDate.toLowerCase().contains(keyword);
      }).toList();
    }

    notifyListeners();
  }

  /// subscription search
  void searchSubscriptions(String value) {
    searchText = value.trim();

    if (searchText.isEmpty) {
      subscriptionEarnings = List.from(_allSubscriptionEarnings);
    } else {
      final keyword = searchText.toLowerCase();

      subscriptionEarnings = _allSubscriptionEarnings.where((item) {
        return 
            item.partnerName.toLowerCase().contains(keyword) ||
            item.status.toLowerCase().contains(keyword);
      }).toList();
    }

    notifyListeners();
  }

  /// =========================================
  /// TOTALS
  /// =========================================

  double get totalBookingEarning {
    return _allBookingEarnings.fold(
      0,
          (sum, item) => sum + item.totalAmount,
    );
  }

  double get totalSubscriptionEarning {
    return _allSubscriptionEarnings.fold(
      0,
          (sum, item) => sum + item.amount,
    );
  }

  double get grandTotalEarning {
    return totalBookingEarning + totalSubscriptionEarning;
  }

  /// booking count
  int get totalBookingCount => _allBookingEarnings.length;

  /// subscription count
  int get totalSubscriptionCount => _allSubscriptionEarnings.length;
}