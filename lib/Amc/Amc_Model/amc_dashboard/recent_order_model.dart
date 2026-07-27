class RecentOrderModel {
  final int id;
  final String amcId;
  final String serviceName;
  final String userPhone;
  final String status;
  final String bookingStatus;
  final String? partnerName;
  final String date;
  final String timeSlot;
  final String description;
  final String address;
  final String payment;
  final String price;

  RecentOrderModel({
    required this.id,
    required this.amcId,
    required this.serviceName,
    required this.userPhone,
    required this.status,
    required this.bookingStatus,
    required this.partnerName,
    required this.date,
    required this.timeSlot,
    required this.description,
    required this.address,
    required this.payment,
    required this.price,
  });

  factory RecentOrderModel.fromJson(Map<String, dynamic> json) {
    return RecentOrderModel(
      id: json["id"] ?? 0,
      amcId: json["amcId"] ?? "",
      serviceName: json["serviceName"] ?? "",
      userPhone: json["userPhone"] ?? "",
      status: json["status"] ?? "",
      bookingStatus: json["bookingStatus"] ?? "",
      partnerName: json["partnerName"],
      date: json["date"] ?? "",
      timeSlot: json["timeSlot"] ?? "",
      description: json["description"] ?? "",
      address: json["address"] ?? "",
      payment: json["payment"] ?? "",
      price: json["price"].toString(),
    );
  }
}