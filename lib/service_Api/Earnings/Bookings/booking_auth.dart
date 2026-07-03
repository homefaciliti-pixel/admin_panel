import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../service_model/earnings_model/Booking_model/booking_model.dart';

class BookingAuth extends ChangeNotifier {
  static const String baseUrl =
      "https://adminbackend-1-h03r.onrender.com/api/earnings/bookings";

  bool isLoading = false;
  String? error;
  bool _loaded = false;

  List<BookingModel> _allBookings = [];
  List<BookingModel> bookingEarnings = [];

  double totalBookingEarning = 0;
  int totalBookingCount = 0;

  Future<void> loadBookings() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        totalBookingEarning =
            (json["totalBookingEarnings"] as num?)?.toDouble() ?? 0;

        totalBookingCount = json["totalTransactions"] ?? 0;

        final List list = json["data"] ?? [];

        _allBookings = list.map((e) => BookingModel.fromJson(e)).toList();

        bookingEarnings = List.from(_allBookings);
      }
    } catch (e) {
      error = e.toString();
      debugPrint(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void searchBookings(String value) {
    if (value.trim().isEmpty) {
      bookingEarnings = List.from(_allBookings);
    } else {
      bookingEarnings = _allBookings.where((item) {
        return item.transactionId.toLowerCase().contains(value.toLowerCase()) ||
            item.paymentMethod.toLowerCase().contains(value.toLowerCase());
      }).toList();
    }

    notifyListeners();
  }
}
