class SubscriptionModel {
  final int id;
  final String partnerName;
  final double amount;
  final String paymentMethod;
  final String purchaseDate;
  final String status;

  SubscriptionModel({
    required this.id,
    required this.partnerName,
    required this.amount,
    required this.paymentMethod,
    required this.purchaseDate,
    required this.status,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id'] ?? 0,
      partnerName: json['partnerName'] ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      paymentMethod: json['paymentMethod'] ?? '',
      purchaseDate: json['purchaseDate'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
