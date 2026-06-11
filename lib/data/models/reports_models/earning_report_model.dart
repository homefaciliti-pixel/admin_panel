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

  factory EarningReportModel.fromJson(Map<String, dynamic> json) {
    return EarningReportModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '') ?? 0,
      source: json['source'] ?? 'Booking',
      title: json['title'] ?? 'Txn ID: ${json['transactionId'] ?? ''}',
      amount: json['amount'] is num
          ? (json['amount'] as num).toDouble()
          : json['totalAmount'] is num
              ? (json['totalAmount'] as num).toDouble()
              : double.tryParse(json['totalAmount']?.toString() ?? '') ?? 0.0,
      paymentMethod: json['paymentMethod'] ?? '',
      createdAt: json['createdAt'] ?? json['orderDate'] ?? '',
      locality: json['locality'] ?? 'N/A',
    );
  }
}