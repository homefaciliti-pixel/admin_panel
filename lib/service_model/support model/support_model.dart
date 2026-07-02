class SupportModel {
  final int id;
  final String userName;
  final String email;
  final String mobile;
  final String subject;
  final String message;
  final String status;
  final String createdAt;
  final int? partnerId;
  final String partnerImage;
  final List<String> partnerDocuments;

  SupportModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.mobile,
    required this.subject,
    required this.message,
    required this.status,
    required this.createdAt,
    this.partnerId,
    required this.partnerImage,
    required this.partnerDocuments,
  });

  factory SupportModel.fromJson(Map<String, dynamic> json) {
    return SupportModel(
      id: json["id"] ?? 0,
      userName: json["userName"] ?? "",
      email: json["email"] ?? "",
      mobile: json["mobile"] ?? "",
      subject: json["subject"] ?? "",
      message: json["message"] ?? "",
      status: json["status"] ?? "",
      createdAt: json["createdAt"] ?? "",
      partnerId: json["partnerId"],
      partnerImage: json["partnerImage"] ?? "",
      partnerDocuments: List<String>.from(json["partnerDocuments"] ?? []),
    );
  }
}