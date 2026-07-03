import '../../partner/partner_model.dart';

class SubscriptionModel {
  final int id;
  final int? partnerId;
  final String partnerName;
  final double amount;
  final String paymentMethod;
  final String purchaseDate;
  final String status;
  final PartnerModel? partnerDetails;

  SubscriptionModel({
    required this.id,
    required this.partnerId,
    required this.partnerName,
    required this.amount,
    required this.paymentMethod,
    required this.purchaseDate,
    required this.status,
    required this.partnerDetails,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json["id"] ?? 0,
      partnerId: json["partnerId"],
      partnerName: json["partnerName"] ?? "",
      amount: double.parse(json["amount"].toString()),
      paymentMethod: json["paymentMethod"] ?? "",
      purchaseDate: json["purchaseDate"] ?? "",
      status: json["status"] ?? "",
      partnerDetails: json["partnerDetails"] != null
          ? PartnerModel.fromJson(json["partnerDetails"])
          : null,
    );
  }
}