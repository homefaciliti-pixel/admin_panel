class SupportDetailModel {
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
  final PartnerModel? partner;

  SupportDetailModel({
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
    this.partner,
  });

  factory SupportDetailModel.fromJson(Map<String, dynamic> json) {
    return SupportDetailModel(
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
      partner: json["partner"] == null
          ? null
          : PartnerModel.fromJson(json["partner"]),
    );
  }
}

class PartnerModel {
  final int id;
  final String name;
  final String email;
  final String mobile;
  final String image;
  final List<String> documents;
  final String aadharFront;
  final String aadharBack;
  final String panImage;
  final String policeVerificationImage;
  final String source;

  PartnerModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.image,
    required this.documents,
    required this.aadharFront,
    required this.aadharBack,
    required this.panImage,
    required this.policeVerificationImage,
    required this.source,
  });

  factory PartnerModel.fromJson(Map<String, dynamic> json) {
    return PartnerModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      mobile: json["mobile"] ?? "",
      image: json["image"] ?? "",
      documents: List<String>.from(json["documents"] ?? []),
      aadharFront: json["aadharFront"] ?? "",
      aadharBack: json["aadharBack"] ?? "",
      panImage: json["panImage"] ?? "",
      policeVerificationImage: json["policeVerificationImage"] ?? "",
      source: json["source"] ?? "",
    );
  }
}
