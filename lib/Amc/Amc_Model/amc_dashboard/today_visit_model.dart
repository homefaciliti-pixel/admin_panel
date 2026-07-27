class VisitModel {
  final int id;
  final String amcId;
  final String userPhone;
  final String scheduledDate;
  final String timeSlot;
  final String status;

  final String? partnerName;
  final String? partnerPhone;

  final String serviceName;
  final String description;

  final String? images;
  final String? otp;
  final String? completedAt;
  final String createdAt;

  // ===== Extra fields for Visit Details =====

  final String? partnerId;
  final String? partnerEmail;

  final String? notes;
  final String? customerFeedback;

  final String? beforeImage;
  final String? afterImage;

  final double rating;

  VisitModel({
    required this.id,
    required this.amcId,
    required this.userPhone,
    required this.scheduledDate,
    required this.timeSlot,
    required this.status,
    this.partnerName,
    this.partnerPhone,
    required this.serviceName,
    required this.description,
    this.images,
    this.otp,
    this.completedAt,
    required this.createdAt,

    this.partnerId,
    this.partnerEmail,
    this.notes,
    this.customerFeedback,
    this.beforeImage,
    this.afterImage,
    this.rating = 0,
  });

  factory VisitModel.fromJson(Map<String, dynamic> json) {
    return VisitModel(
      id: json["id"] ?? 0,
      amcId: json["amcId"] ?? "",
      userPhone: json["userPhone"] ?? "",
      scheduledDate: json["scheduledDate"] ?? "",
      timeSlot: json["timeSlot"] ?? "",
      status: json["status"] ?? "",
      partnerName: json["partnerName"],
      partnerPhone: json["partnerPhone"],
      serviceName: json["serviceName"] ?? "",
      description: json["description"] ?? "",
      images: json["images"],
      otp: json["otp"],
      completedAt: json["completedAt"],
      createdAt: json["createdAt"] ?? "",

      partnerId: json["partnerId"],
      partnerEmail: json["partnerEmail"],
      notes: json["notes"],
      customerFeedback: json["customerFeedback"],
      beforeImage: json["beforeImage"],
      afterImage: json["afterImage"],
      rating: double.tryParse(json["rating"].toString()) ?? 0,
    );
  }

  // ===== Helpers for old UI =====

  String get visitDate => scheduledDate.split("T").first;

  String get visitTime => timeSlot;

  int get visitNumber => id;
}