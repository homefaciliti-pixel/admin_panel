class AdminAmcModel {
  final String amcId;
  final String userName;
  final String phone;
  final String category;
  final int areaSqFt;
  final int floors;
  final double amount;
  final String status;
  final DateTime startDate;
  final DateTime endDate;

  AdminAmcModel({
    required this.amcId,
    required this.userName,
    required this.phone,
    required this.category,
    required this.areaSqFt,
    required this.floors,
    required this.amount,
    required this.status,
    required this.startDate,
    required this.endDate,
  });

  factory AdminAmcModel.fromJson(Map<String, dynamic> json) {
    return AdminAmcModel(
      amcId: json["amcId"] ?? "",

      userName: json["userName"] ?? "",

      phone: json["phone"] ?? "",

      category: json["category"] ?? "",

      areaSqFt: json["areaSqFt"] ?? 0,

      floors: json["floors"] ?? 0,

      amount: (json["price"] ?? 0).toDouble(),

      status: json["status"] ?? "",

      startDate: DateTime.parse(json["startDate"]),

      endDate: DateTime.parse(json["endDate"]),
    );
  }
}
