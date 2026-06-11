import 'package:flutter/material.dart';
import '../data/models/booking_earning_model.dart';
import '../data/models/subscription_earning_model.dart';
import '../data/services/api_service.dart';

/// earnings screen ke tabs
enum EarningsTab {
  bookings,
  subscriptions,
}

class EarningsViewModel extends ChangeNotifier {
  final ApiService _api = ApiService();
  bool isLoading = false;

  /// currently selected tab
  EarningsTab currentTab = EarningsTab.bookings;

  /// tab change karne ke liye
  void changeTab(EarningsTab tab) {
    currentTab = tab;
    notifyListeners();
  }

  /// master lists
  final List<BookingEarningModel> _allBookingEarnings = [];
  final List<SubscriptionEarningModel> _allSubscriptionEarnings = [];

  /// visible lists
  List<BookingEarningModel> bookingEarnings = [];
  List<SubscriptionEarningModel> subscriptionEarnings = [];

  /// search text
  String searchText = "";

  /// constructor
  EarningsViewModel() {
    loadEarnings();
  }

  Future<void> loadEarnings() async {
    isLoading = true;
    notifyListeners();

    final bList = await _api.getBookingEarnings();
    final sList = await _api.getSubscriptionEarnings();

    _allBookingEarnings.clear();
    _allBookingEarnings.addAll(bList);

    _allSubscriptionEarnings.clear();
    _allSubscriptionEarnings.addAll(sList);

    bookingEarnings = List.from(_allBookingEarnings);
    subscriptionEarnings = List.from(_allSubscriptionEarnings);

    isLoading = false;
    notifyListeners();
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
        return item.partnerName.toLowerCase().contains(keyword) ||
            item.status.toLowerCase().contains(keyword);
      }).toList();
    }

    notifyListeners();
  }

  /// totals
  double get totalBookingEarning {
    return _allBookingEarnings.fold(
      0.0,
      (sum, item) => sum + item.totalAmount,
    );
  }

  double get totalSubscriptionEarning {
    return _allSubscriptionEarnings.fold(
      0.0,
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