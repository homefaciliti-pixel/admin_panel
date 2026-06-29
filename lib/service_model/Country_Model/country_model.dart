class CountryModel {
  final String name;
  final String code;
  final String dialCode;
  final String emoji;
  final String image;

  CountryModel({
    required this.name,
    required this.code,
    required this.dialCode,
    required this.emoji,
    required this.image,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json["name"],
      code: json["code"],
      dialCode: json["dialCode"],
      emoji: json["emoji"],
      image: json["image"],
    );
  }
}