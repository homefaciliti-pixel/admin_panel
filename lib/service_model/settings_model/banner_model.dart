class BannerModel {
  /// Banner ID
  final int id;

  /// Banner title
  final String title;

  /// Banner image URL returned by backend
  final String image;

  /// Banner status
  final bool status;

  /// Category (for navigation in user app)
  final String category;

  /// Badge text (e.g. "100% FREE", "COMING SOON")
  final String badge;

  /// Subtitle / description
  final String subtitle;

  /// Button text
  final String buttonText;

  BannerModel({
    required this.id,
    required this.title,
    required this.image,
    required this.status,
    this.category = '',
    this.badge = '',
    this.subtitle = '',
    this.buttonText = 'Book Now',
  });

  /// API JSON -> Model
  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      status: json['status'] ?? false,
      category: json['category'] ?? '',
      badge: json['badge'] ?? '',
      subtitle: json['subtitle'] ?? '',
      buttonText: json['buttonText'] ?? 'Book Now',
    );
  }

  /// Copy helper
  BannerModel copyWith({
    int? id,
    String? title,
    String? image,
    bool? status,
    String? category,
    String? badge,
    String? subtitle,
    String? buttonText,
  }) {
    return BannerModel(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      status: status ?? this.status,
      category: category ?? this.category,
      badge: badge ?? this.badge,
      subtitle: subtitle ?? this.subtitle,
      buttonText: buttonText ?? this.buttonText,
    );
  }
}