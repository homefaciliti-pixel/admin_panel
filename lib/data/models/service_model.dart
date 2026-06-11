class ServiceModel {
  /// unique service id
  final int id;

  /// service title
  final String title;

  /// service price
  final double price;

  /// service discount
  final double discount;

  /// service image path/url
  final String image;

  /// service description
  final String description;

  /// active / inactive
  bool status;

  /// featured / highlighted service
  String isHighlighted;

  /// optional category id
  final int? categoryId;

  /// optional rating
  final double? rating;

  /// optional time duration
  final String? time;

  ServiceModel({
    required this.id,
    required this.title,
    required this.price,
    this.discount = 0.0,
    required this.image,
    required this.description,
    required this.status,
    this.isHighlighted = "",
    this.categoryId,
    this.rating,
    this.time,
  });

  /// copyWith - ek-ek field update karne ke kaam aata hai
  ServiceModel copyWith({
    int? id,
    String? title,
    double? price,
    double? discount,
    String? image,
    String? description,
    bool? status,
    String? isHighlighted,
    int? categoryId,
    double? rating,
    String? time,
  }) {
    return ServiceModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      image: image ?? this.image,
      description: description ?? this.description,
      status: status ?? this.status,
      isHighlighted: isHighlighted ?? this.isHighlighted,
      categoryId: categoryId ?? this.categoryId,
      rating: rating ?? this.rating,
      time: time ?? this.time,
    );
  }
}