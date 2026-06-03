class PageModel {
  final int id;
  final String title;
  final String description;

  PageModel({
    required this.id,
    required this.title,
    required this.description,
  });

  factory PageModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return PageModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }

  PageModel copyWith({
    int? id,
    String? title,
    String? description,
  }) {
    return PageModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}