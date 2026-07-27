class AmcOrderModel {
  final int id;
  final String amcId;

  final String userPhone;
  final String serviceName;
  final String description;

  final double price;

  final String date;
  final String? timeSlot;

  final String status;
  final String bookingStatus;

  final String? partnerName;
  final String? partnerPhone;
  final double? partnerRating;
  final String? partnerStatus;
  final double? partnerDistance;

  final String productId;

  final String address;
  final String payment;

  final String? razorpayOrderId;
  final String? razorpayPaymentId;

  final int createdAt;

  final double advancePayment;
  final double remainingAmount;
  final double platformCharge;

  final String? cancelReason;

  const AmcOrderModel({
    required this.id,
    required this.amcId,
    required this.userPhone,
    required this.serviceName,
    required this.description,
    required this.price,
    required this.date,
    required this.timeSlot,
    required this.status,
    required this.bookingStatus,
    required this.partnerName,
    required this.partnerPhone,
    required this.partnerRating,
    required this.partnerStatus,
    required this.partnerDistance,
    required this.productId,
    required this.address,
    required this.payment,
    required this.razorpayOrderId,
    required this.razorpayPaymentId,
    required this.createdAt,
    required this.advancePayment,
    required this.remainingAmount,
    required this.platformCharge,
    required this.cancelReason,
  });

  factory AmcOrderModel.fromJson(Map<String, dynamic> json) {
    return AmcOrderModel(
      id: json["id"] ?? 0,
      amcId: json["amcId"] ?? "",

      userPhone: json["userPhone"] ?? "",
      serviceName: json["serviceName"] ?? "",
      description: json["description"] ?? "",

      price: double.tryParse(json["price"].toString()) ?? 0,

      date: json["date"] ?? "",
      timeSlot: json["timeSlot"],

      status: json["status"] ?? "",
      bookingStatus: json["bookingStatus"] ?? "",

      partnerName: json["partnerName"],
      partnerPhone: json["partnerPhone"],
      partnerRating: json["partnerRating"] == null
          ? 0
          : double.tryParse(json["partnerRating"].toString()) ?? 0,
      partnerStatus: json["partnerStatus"] ?? "Not Assigned",

      partnerDistance: json["partnerDistance"] == null
          ? null
          : double.tryParse(json["partnerDistance"].toString()),

      productId: json["productId"] ?? "",

      address: json["address"] ?? "",
      payment: json["payment"] ?? "",

      razorpayOrderId: json["razorpayOrderId"],
      razorpayPaymentId: json["razorpayPaymentId"],

      createdAt: json["createdAt"] ?? 0,

      advancePayment:
      double.tryParse(json["advancePayment"].toString()) ?? 0,

      remainingAmount:
      double.tryParse(json["remainingAmount"].toString()) ?? 0,

      platformCharge:
      double.tryParse(json["platformCharge"].toString()) ?? 0,

      cancelReason: json["cancelReason"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "amcId": amcId,
      "userPhone": userPhone,
      "serviceName": serviceName,
      "description": description,
      "price": price,
      "date": date,
      "timeSlot": timeSlot,
      "status": status,
      "bookingStatus": bookingStatus,
      "partnerName": partnerName,
      "partnerPhone": partnerPhone,
      "partnerRating": partnerRating,
      "partnerStatus": partnerStatus,
      "partnerDistance": partnerDistance,
      "productId": productId,
      "address": address,
      "payment": payment,
      "razorpayOrderId": razorpayOrderId,
      "razorpayPaymentId": razorpayPaymentId,
      "createdAt": createdAt,
      "advancePayment": advancePayment,
      "remainingAmount": remainingAmount,
      "platformCharge": platformCharge,
      "cancelReason": cancelReason,
    };
  }
}