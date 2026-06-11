class PageModel {

  /// unique page id
  final int id;

  /// page title
  final String title;

  /// page description/content
  final String description;

  PageModel({

    required this.id,

    required this.title,

    required this.description,
  });

  /// copyWith
  ///
  /// edit/update ke kaam aayega

  PageModel copyWith({

    int? id,

    String? title,

    String? description,
  }) {

    return PageModel(

      id: id ?? this.id,

      title: title ?? this.title,

      description:
      description ?? this.description,
    );
  }
}