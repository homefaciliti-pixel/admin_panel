import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../service_model/earnings_model/Booking_model/subscription_model.dart';

class SubscriptionAuth extends ChangeNotifier {
  static const String _baseUrl =
      'https://adminbackend-1-h03r.onrender.com/api/earnings/subscriptions';

  bool isLoading = false;
  String? error;
  bool _loaded = false;

  List<SubscriptionModel> _allSubscriptions = [];
  List<SubscriptionModel> subscriptionEarnings = [];

  /// Screen ke liye exact same names
  double totalSubscriptionEarning = 0;
  int totalSubscriptionCount = 0;

  Future<void> loadSubscriptions({bool forceRefresh = false}) async {
    if (_loaded && !forceRefresh ) return;
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        /// API response ke keys
        totalSubscriptionEarning =
            (json['totalSubscriptionsEarnings'] as num?)?.toDouble() ?? 0.0;

        totalSubscriptionCount = json['totalPlans'] ?? 0;

        final List list = json['data'] ?? [];
        _allSubscriptions = list
            .map((e) => SubscriptionModel.fromJson(e))
            .toList();

        subscriptionEarnings = List.from(_allSubscriptions);
      } else {
        error = 'Subscription API error: ${response.statusCode}';

        _loaded; true;
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void searchSubscriptions(String value) {
    if (value.trim().isEmpty) {
      subscriptionEarnings = List.from(_allSubscriptions);
    } else {
      final keyword = value.toLowerCase();
      subscriptionEarnings = _allSubscriptions.where((item) {
        return item.partnerName.toLowerCase().contains(keyword) ||
            item.paymentMethod.toLowerCase().contains(keyword) ||
            item.status.toLowerCase().contains(keyword) ||
            item.purchaseDate.toLowerCase().contains(keyword);
      }).toList();
    }

    notifyListeners();
  }
}
