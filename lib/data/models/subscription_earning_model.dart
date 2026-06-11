class SubscriptionEarningModel {
  final int id;

  final String partnerName;
  final double amount;
  final String paymentMethod;
  final String purchaseDate;
  final String status;

  SubscriptionEarningModel({
    required this.id,

    required this.partnerName,
    required this.amount,
    required this.paymentMethod,
    required this.purchaseDate,
    required this.status,
  });
}