import 'dart:convert';
import 'dart:typed_data';

class ServiceModel {
  final int id;
  final String title;
  final double price;




  final double discountAmount;

  double get discountPercent {
    if (price <= 0) return 0;
    return (discountAmount / price) * 100;
  }

  /// final price after discount
  double get discountPrice =>
      (price - discountAmount).clamp(0, double.infinity);

  final String? imageUrl;
  final List<int>? imageBytes;
  final String description;
  final bool status;
  final String? categoryId;
  final double? rating;
  final String? time;
  final bool isHighlighted;
  final List<String> highlights;
  final int reviewsCount;
  final double cutPrice;

  ServiceModel({
    required this.id,
    required this.title,
    required this.price,
    required this.discountAmount,
    required this.imageUrl,
    required this.imageBytes,
    required this.description,
    required this.status,
    required this.categoryId,
    required this.rating,
    required this.time,
    required this.isHighlighted,
    required this.highlights,
    required this.reviewsCount,
    required this.cutPrice,
  });

  static String _normalizeUrl(String url) {
    if (url.startsWith('http://') &&
        !url.contains('localhost') &&
        !url.contains('127.0.0.1') &&
        !url.contains('10.0.2.2')) {
      return url.replaceFirst('http://', 'https://');
    }
    return url;
  }

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    final price = (json['price'] as num?)?.toDouble() ?? 0;

    final discountRaw = json['discount'];
    final discountAmount = discountRaw is num
        ? discountRaw.toDouble()
        : double.tryParse(discountRaw?.toString() ?? '0') ?? 0;

    return ServiceModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title']?.toString() ?? '',
      price: price,
      discountAmount: discountAmount,

      // backend se jo image url aaye, wahi show hoga, dynamically normalized to HTTPS
      imageUrl: (json['image']?.toString().isNotEmpty ?? false)
          ? _normalizeUrl(json['image'].toString())
          : null,

      imageBytes: null,
      description: json['description']?.toString() ?? '',
      status: json['status'] == true,
      categoryId: json['categoryId']?.toString() ?? json['category_id']?.toString(),
      rating: (json['rating'] as num?)?.toDouble(),
      time: json['time']?.toString(),
      isHighlighted: json['isHighlighted'] == true || json['isHighlighted'] == 'true',
      highlights: json['highlights'] != null
          ? List<String>.from(json['highlights'] is String
              ? jsonDecode(json['highlights'])
              : json['highlights'])
          : const [],
      reviewsCount: 0,
      cutPrice: (json['cutPrice'] as num?)?.toDouble() ?? 0,
    );
  }

  ServiceModel copyWith({
    int? id,
    String? title,
    double? price,
    double? discountAmount,
    String? imageUrl,
    List<int>? imageBytes,
    String? description,
    bool? status,
    String? categoryId,
    double? rating,
    String? time,
    bool? isHighlighted,
    List<String>? highlights,
    int? reviewsCount,
    double? cutPrice,
  }) {
    return ServiceModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      discountAmount: discountAmount ?? this.discountAmount,
      imageUrl: imageUrl ?? this.imageUrl,
      imageBytes: imageBytes ?? this.imageBytes,
      description: description ?? this.description,
      status: status ?? this.status,
      categoryId: categoryId ?? this.categoryId,
      rating: rating ?? this.rating,
      time: time ?? this.time,
      isHighlighted: isHighlighted ?? this.isHighlighted,
      highlights: highlights ?? this.highlights,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      cutPrice: cutPrice ?? this.cutPrice,
    );
  }
}