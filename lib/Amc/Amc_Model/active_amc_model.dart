class ActiveAmcModel {
  final String id;
  final String amcId;

  final String customerName;
  final String customerPhone;
  final String userPhone;

  final String category;
  final String planName;

  final double price;
  final int areaSqFt;
  final int floors;

  final String houseType;
  final String address;

  final String status;

  final String startDate;
  final String endDate;
  final String createdAt;

  final int totalVisits;
  final int completedVisits;
  final int remainingVisits;

  final String assignedPartner;
  final String partnerPhone;

  final String? photoUrl;
  final String? pdfUrl;
  final String? fileUrl;

  const ActiveAmcModel({
    required this.id,
    required this.amcId,
    required this.customerName,
    required this.customerPhone,
    required this.userPhone,
    required this.category,
    required this.planName,
    required this.price,
    required this.areaSqFt,
    required this.floors,
    required this.houseType,
    required this.address,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.totalVisits,
    required this.completedVisits,
    required this.remainingVisits,
    required this.assignedPartner,
    required this.partnerPhone,
    this.photoUrl,
    this.pdfUrl,
    this.fileUrl,
  });

  factory ActiveAmcModel.fromJson(Map<String, dynamic> json) {
    return ActiveAmcModel(
      id: json["id"] ?? "",
      amcId: json["amcId"] ?? "",

      customerName: json["customerName"] ?? "",
      customerPhone: json["customerPhone"] ?? "",
      userPhone: json["userPhone"] ?? "",

      category: json["category"] ?? "",
      planName: json["planName"] ?? "",

      price: double.tryParse(json["price"].toString()) ?? 0,

      areaSqFt: json["areaSqFt"] ?? 0,
      floors: json["floors"] ?? 0,

      houseType: json["houseType"] ?? "",

      address: json["address"] ?? "",

      status: json["status"] ?? "",

      startDate: json["startDate"] ?? "",
      endDate: json["endDate"] ?? "",
      createdAt: json["createdAt"] ?? "",

      totalVisits: json["totalVisits"] ?? 0,
      completedVisits: json["completedVisits"] ?? 0,
      remainingVisits: json["remainingVisits"] ?? 0,

      assignedPartner: json["assignedPartner"] ?? "",
      partnerPhone: json["partnerPhone"] ?? "",

      photoUrl: json["photoUrl"],
      pdfUrl: json["pdfUrl"],
      fileUrl: json["fileUrl"],
    );
  }
}