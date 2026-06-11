class UserReportModel {
  final int id;
  final String userName;
  final String mobile;
  final String createdAt;
  final String locality;

  UserReportModel({
    required this.id,
    required this.userName,
    required this.mobile,
    required this.createdAt,
    required this.locality,
  });

  factory UserReportModel.fromJson(Map<String, dynamic> json) {
    return UserReportModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '') ?? 0,
      userName: json['name'] ?? json['userName'] ?? '',
      mobile: json['mobile'] ?? '',
      createdAt: json['createdAt'] ?? '',
      locality: json['address'] ?? json['locality'] ?? '',
    );
  }
}