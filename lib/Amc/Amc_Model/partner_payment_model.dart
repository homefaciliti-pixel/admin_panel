class PartnerPaymentModel {
  final int id;
  final int visitId;
  final String amcId;
  final String partnerPhone;
  final String partnerName;
  final double amount;
  final String status;

  final DateTime createdAt;
  final DateTime? releasedAt;

  final int paymentId;

  final String? razorpayPaymentId;
  final String? razorpayOrderId;

  const PartnerPaymentModel({
    required this.id,
    required this.visitId,
    required this.amcId,
    required this.partnerPhone,
    required this.partnerName,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.paymentId,
    this.releasedAt,
    this.razorpayPaymentId,
    this.razorpayOrderId,
  });

  factory PartnerPaymentModel.fromJson(
      Map<String, dynamic> json) {
    return PartnerPaymentModel(
      id: json["id"] ?? 0,
      visitId: json["visitId"] ?? 0,
      amcId: json["amcId"] ?? "",
      partnerPhone: json["partnerPhone"] ?? "",
      partnerName: json["partnerName"] ?? "",
      amount:
      double.tryParse(json["amount"].toString()) ??
          0.0,
      status: json["status"] ?? "",

      createdAt:
      DateTime.parse(json["createdAt"]),

      releasedAt: json["releasedAt"] != null
          ? DateTime.parse(json["releasedAt"])
          : null,

      paymentId: json["paymentId"] ?? 0,

      razorpayPaymentId:
      json["razorpayPaymentId"]?.toString(),

      razorpayOrderId:
      json["razorpayOrderId"]?.toString(),
    );
  }
}