class CityModel {
  /// City ID from backend
  final int id;

  /// City name
  final String cityName;

  /// State name
  final String stateName;

  /// Active / inactive
  bool status;

  CityModel({
    required this.id,
    required this.cityName,
    required this.stateName,
    required this.status,
  });

  /// API JSON -> Model
  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] ?? 0,
      cityName: json['cityName'] ?? '',
      stateName: json['stateName'] ?? '',
      status: json['status'] ?? false,
    );
  }

  /// Copy helper
  CityModel copyWith({
    int? id,
    String? cityName,
    String? stateName,
    bool? status,
  }) {
    return CityModel(
      id: id ?? this.id,
      cityName: cityName ?? this.cityName,
      stateName: stateName ?? this.stateName,
      status: status ?? this.status,
    );
  }
}