class BookingModel {
  final int id;
  final String transactionId;
  final double serviceAmount;
  final String paymentMethod;
  final double extraServiceAmount;
  final String extraServicePaymentMethod;
  final double totalAmount;
  final String orderDate;

  BookingModel({
    required this.id,
    required this.transactionId,
    required this.serviceAmount,
    required this.paymentMethod,
    required this.extraServiceAmount,
    required this.extraServicePaymentMethod,
    required this.totalAmount,
    required this.orderDate,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] ?? 0,
      transactionId: json['transactionId'] ?? '',
      serviceAmount:
      (json['serviceAmount'] as num?)?.toDouble() ?? 0.0,
      paymentMethod: json['paymentMethod'] ?? '',
      extraServiceAmount:
      (json['extraServiceAmount'] as num?)?.toDouble() ?? 0.0,
      extraServicePaymentMethod:
      json['extraServicePaymentMethod'] ?? '',
      totalAmount:
      (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
      orderDate: json['orderDate'] ?? '',
    );
  }
}