class BookingModel {
  final int id;
  final int? userId;

  final String transactionId;
  final double serviceAmount;
  final String paymentMethod;

  final double extraServiceAmount;
  final String extraServicePaymentMethod;

  final double totalAmount;
  final String orderDate;

  final UserDetails? userDetails;

  BookingModel({
    required this.id,
    required this.userId,
    required this.transactionId,
    required this.serviceAmount,
    required this.paymentMethod,
    required this.extraServiceAmount,
    required this.extraServicePaymentMethod,
    required this.totalAmount,
    required this.orderDate,
    required this.userDetails,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] ?? 0,

      userId: json['userId'],

      transactionId: json['transactionId'] ?? '',

      serviceAmount:
      (json['serviceAmount'] as num?)?.toDouble() ?? 0.0,

      paymentMethod:
      json['paymentMethod'] ?? '',

      extraServiceAmount:
      (json['extraServiceAmount'] as num?)?.toDouble() ?? 0.0,

      extraServicePaymentMethod:
      json['extraServicePaymentMethod'] ?? '',

      totalAmount:
      (json['totalAmount'] as num?)?.toDouble() ?? 0.0,

      orderDate:
      json['orderDate'] ?? '',

      userDetails: json['userDetails'] != null
          ? UserDetails.fromJson(json['userDetails'])
          : null,
    );
  }
}


class UserDetails {

  final int id;
  final String name;
  final String email;
  final String mobile;
  final String address;
  final String gender;
  final String source;
  final String countryCode;

  UserDetails({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.address,
    required this.gender,
    required this.source,
    required this.countryCode,
  });


  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(

      id: json['id'] ?? 0,

      name: json['name'] ?? '',

      email: json['email'] ?? '',

      mobile: json['mobile'] ?? '',

      address: json['address'] ?? '',

      gender: json['gender'] ?? '',

      source: json['source'] ?? '',

      countryCode: json['countryCode'] ?? '',
    );
  }
}