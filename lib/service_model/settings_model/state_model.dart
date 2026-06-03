class StateModel {
  /// State ID from backend
  final int id;

  /// State name
  final String name;

  /// State active/inactive
  bool status;

  StateModel({
    required this.id,
    required this.name,
    required this.status,
  });

  /// API JSON -> model
  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      status: json['status'] ?? false,
    );
  }

  /// Copy helper
  StateModel copyWith({
    int? id,
    String? name,
    bool? status,
  }) {
    return StateModel(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }
}