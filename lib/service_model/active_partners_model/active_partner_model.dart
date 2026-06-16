class ActivePartnerModel {
  final String partnerId;
  final String profileImage;

  final String name;
  final String phone;

  final String category;
  final String subCategory;

  final String area;

  final double latitude;
  final double longitude;

  final int currentOrders;

  final bool isOnline;

  final String activeAt;
  final String lastActive;

  ActivePartnerModel({
    required this.partnerId,
    required this.profileImage,
    required this.name,
    required this.phone,
    required this.category,
    required this.subCategory,
    required this.area,
    required this.latitude,
    required this.longitude,
    required this.currentOrders,
    required this.isOnline,
    required this.activeAt,
    required this.lastActive,
  });

  factory ActivePartnerModel.fromJson(Map<String, dynamic> json) {
    return ActivePartnerModel(
      partnerId: json["partnerId"] ?? "",
      profileImage: json["profileImage"] ?? "",
      name: json["name"] ?? "",
      phone: json["phone"] ?? "",
      category: json["category"] ?? "",
      subCategory: json["subCategory"] ?? "",
      area: json["area"] ?? "",

      latitude: (json["latitude"] ?? 0).toDouble(),
      longitude: (json["longitude"] ?? 0).toDouble(),

      currentOrders: json["currentOrders"] ?? 0,
      isOnline: json["isOnline"] ?? false,

      activeAt: json["activeAt"]?.toString() ?? "",
      lastActive: json["lastActive"]?.toString() ?? "",
    );
  }
}
