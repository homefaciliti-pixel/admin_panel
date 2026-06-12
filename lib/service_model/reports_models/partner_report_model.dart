class PartnerReportModel {
  final int id;
  final String partnerName;
  final String mobile;
  final String createdAt;
  final String locality;

  PartnerReportModel({
    required this.id,
    required this.partnerName,
    required this.mobile,
    required this.createdAt,
    required this.locality,
  });

  factory PartnerReportModel.fromJson(Map<String, dynamic> json) {
    return PartnerReportModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '') ?? 0,
      partnerName: json['name'] ?? json['partnerName'] ?? '',
      mobile: json['mobile'] ?? '',
      createdAt: json['createdAt'] ?? '',
      locality: json['locality'] ?? json['address'] ?? '',
    );
  }
}