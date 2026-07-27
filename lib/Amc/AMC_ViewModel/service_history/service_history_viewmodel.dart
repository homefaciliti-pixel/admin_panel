import 'package:flutter/material.dart';
import '../../Amc_Model/service_history_model.dart';

class ServiceHistoryViewModel extends ChangeNotifier {
  bool loading = false;

  final List<ServiceHistoryModel> _history = [];

  List<ServiceHistoryModel> get history => _history;

  Future<void> fetchHistory() async {
    loading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _history.clear();

    _history.addAll([
      const ServiceHistoryModel(
        bookingId: "BK0001",
        serviceName: "Electrical Inspection",
        partnerName: "Rahul Sharma",
        visitDate: "15 Jul 2026",
        visitTime: "10:00 AM",
        status: "Completed",
        notes: "All electrical points checked successfully.",
        rating: 5,
      ),

      const ServiceHistoryModel(
        bookingId: "BK0002",
        serviceName: "Fan Repair",
        partnerName: "Rahul Sharma",
        visitDate: "28 Jul 2026",
        visitTime: "11:30 AM",
        status: "Completed",
        notes: "Fan capacitor replaced.",
        rating: 4,
      ),

      const ServiceHistoryModel(
        bookingId: "BK0003",
        serviceName: "MCB Checking",
        partnerName: "Pending",
        visitDate: "10 Aug 2026",
        visitTime: "03:00 PM",
        status: "Upcoming",
        notes: "",
        rating: 0,
      ),
    ]);

    loading = false;
    notifyListeners();
  }
}