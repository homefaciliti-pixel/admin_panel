class EarningReportModel {
  final int id;
  final String source; // Booking / Subscription
  final String title;
  final double amount;
  final String paymentMethod;
  final String createdAt;
  final String locality;

  EarningReportModel({
    required this.id,
    required this.source,
    required this.title,
    required this.amount,
    required this.paymentMethod,
    required this.createdAt,
    required this.locality,
  });
}