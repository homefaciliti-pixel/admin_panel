import 'package:flutter/foundation.dart';

@immutable
class PartnerPaymentModel {
  final String paymentId;
  final String partnerId;
  final String partnerName;
  final String partnerPhone;

  final String orderId;
  final String amcId;

  final int totalOrders;

  final double serviceAmount;
  final double commission;
  final double payableAmount;

  final String paymentMethod;
  final String transactionId;

  final String paymentDate;
  final String status;

  const PartnerPaymentModel({
    required this.paymentId,
    required this.partnerId,
    required this.partnerName,
    required this.partnerPhone,
    required this.orderId,
    required this.amcId,
    required this.totalOrders,
    required this.serviceAmount,
    required this.commission,
    required this.payableAmount,
    required this.paymentMethod,
    required this.transactionId,
    required this.paymentDate,
    required this.status,
  });

  factory PartnerPaymentModel.fromJson(Map<String, dynamic> json) {
    return PartnerPaymentModel(
      paymentId: json["paymentId"] ?? "",
      partnerId: json["partnerId"] ?? "",
      partnerName: json["partnerName"] ?? "",
      partnerPhone: json["partnerPhone"] ?? "",
      orderId: json["orderId"] ?? "",
      amcId: json["amcId"] ?? "",
      totalOrders: json["totalOrders"] ?? 0,
      serviceAmount: (json["serviceAmount"] ?? 0).toDouble(),
      commission: (json["commission"] ?? 0).toDouble(),
      payableAmount: (json["payableAmount"] ?? 0).toDouble(),
      paymentMethod: json["paymentMethod"] ?? "",
      transactionId: json["transactionId"] ?? "",
      paymentDate: json["paymentDate"] ?? "",
      status: json["status"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "paymentId": paymentId,
      "partnerId": partnerId,
      "partnerName": partnerName,
      "partnerPhone": partnerPhone,
      "orderId": orderId,
      "amcId": amcId,
      "totalOrders": totalOrders,
      "serviceAmount": serviceAmount,
      "commission": commission,
      "payableAmount": payableAmount,
      "paymentMethod": paymentMethod,
      "transactionId": transactionId,
      "paymentDate": paymentDate,
      "status": status,
    };
  }
}
