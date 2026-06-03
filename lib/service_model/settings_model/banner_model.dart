class BannerModel {
  /// Banner ID
  final int id;

  /// Banner title
  final String title;

  /// Banner image URL returned by backend
  final String image;

  /// Banner status
  final bool status;

  BannerModel({
    required this.id,
    required this.title,
    required this.image,
    required this.status,
  });

  /// API JSON -> Model
  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      status: json['status'] ?? false,
    );
  }

  /// Copy helper
  BannerModel copyWith({
    int? id,
    String? title,
    String? image,
    bool? status,
  }) {
    return BannerModel(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      status: status ?? this.status,
    );
  }
}