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
}