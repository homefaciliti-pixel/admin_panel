class BookingEarningModel {

  /// unique id
  final int id;

  /// transaction id
  final String transactionId;

  /// service amount
  final double serviceAmount;

  /// payment method
  final String paymentMethod;

  /// extra service amount
  final double extraServiceAmount;

  /// extra service payment method
  final String extraServicePaymentMethod;

  /// total amount
  final double totalAmount;

  /// order date
  final String orderDate;

  BookingEarningModel({

    required this.id,

    required this.transactionId,

    required this.serviceAmount,

    required this.paymentMethod,

    required this.extraServiceAmount,

    required this.extraServicePaymentMethod,

    required this.totalAmount,

    required this.orderDate,
  });
}