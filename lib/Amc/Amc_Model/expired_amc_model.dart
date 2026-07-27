import 'package:flutter/foundation.dart';

@immutable
class ExpiredAmcModel {
  final String amcId;
  final String customerName;
  final String phone;
  final String category;
  final String partnerName;
  final String address;
  final String status;
  final String startDate;
  final String expiryDate;
  final int totalVisits;
  final int completedVisits;
  final double amount;

  const ExpiredAmcModel({
    required this.amcId,
    required this.customerName,
    required this.phone,
    required this.category,
    required this.partnerName,
    required this.address,
    required this.status,
    required this.startDate,
    required this.expiryDate,
    required this.totalVisits,
    required this.completedVisits,
    required this.amount,
  });

  factory ExpiredAmcModel.fromJson(Map<String, dynamic> json) {
    return ExpiredAmcModel(
      amcId: json["amcId"] ?? "",
      customerName: json["customerName"] ?? "",
      phone: json["phone"] ?? "",
      category: json["category"] ?? "",
      partnerName: json["partnerName"] ?? "",
      address: json["address"] ?? "",
      status: json["status"] ?? "Expired",
      startDate: json["startDate"] ?? "",
      expiryDate: json["expiryDate"] ?? "",
      totalVisits: json["totalVisits"] ?? 0,
      completedVisits: json["completedVisits"] ?? 0,
      amount: json["amount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "amcId": amcId,
      "customerName": customerName,
      "phone": phone,
      "category": category,
      "partnerName": partnerName,
      "address": address,
      "status": status,
      "startDate": startDate,
      "expiryDate": expiryDate,
      "totalVisits": totalVisits,
      "completedVisits": completedVisits,
      "amount": amount
    };
  }
}