class CategoryResponse {
  final bool success;
  final List<CategoryItem> data;

  CategoryResponse({
    required this.success,
    required this.data,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      success: json['success'] ?? false,
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => CategoryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class CategoryItem {
  final int id;
  final String title;
  final String parent;
  final String image;
  final bool status;

  CategoryItem({
    required this.id,
    required this.title,
    required this.parent,
    required this.image,
    required this.status,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      parent: json['parent'] ?? '',
      image: json['image'] ?? '',
      status: json['status'] ?? false,
    );
  }

  CategoryItem copyWith({
    int? id,
    String? title,
    String? parent,
    String? image,
    bool? status,
  }) {
    return CategoryItem(
      id: id ?? this.id,
      title: title ?? this.title,
      parent: parent ?? this.parent,
      image: image ?? this.image,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'parent': parent,
      'image': image,
      'status': status,
    };
  }
}
