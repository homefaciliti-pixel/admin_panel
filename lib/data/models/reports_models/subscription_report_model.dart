class SubscriptionReportModel {
  final int id;
  final String partnerName;
  final String planName;
  final double amount;
  final String createdAt;
  final String locality;

  SubscriptionReportModel({
    required this.id,
    required this.partnerName,
    required this.planName,
    required this.amount,
    required this.createdAt,
    required this.locality,
  });

  factory SubscriptionReportModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionReportModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '') ?? 0,
      partnerName: json['partnerName'] ?? '',
      planName: json['planName'] ?? 'Partner Verification',
      amount: json['amount'] is num
          ? (json['amount'] as num).toDouble()
          : double.tryParse(json['amount']?.toString() ?? '') ?? 0.0,
      createdAt: json['createdAt'] ?? json['purchaseDate'] ?? '',
      locality: json['locality'] ?? 'N/A',
    );
  }
}