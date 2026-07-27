class PartnerDropdownModel {
  final int id;
  final String name;
  final String mobile;

  const PartnerDropdownModel({
    required this.id,
    required this.name,
    required this.mobile,
  });

  factory PartnerDropdownModel.fromJson(Map<String, dynamic> json) {
    return PartnerDropdownModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      mobile: json["mobile"] ?? "",
    );
  }
}