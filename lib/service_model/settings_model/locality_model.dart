class LocalityModel {
  /// Locality ID from backend
  final int id;

  /// Locality name
  final String localityName;

  /// City name
  final String cityName;

  /// State name
  final String stateName;

  /// Active / inactive
  bool status;

  LocalityModel({
    required this.id,
    required this.localityName,
    required this.cityName,
    required this.stateName,
    required this.status,
  });

  /// API JSON -> Model
  factory LocalityModel.fromJson(Map<String, dynamic> json) {
    return LocalityModel(
      id: json['id'] ?? 0,
      localityName: json['localityName'] ?? '',
      cityName: json['cityName'] ?? '',
      stateName: json['stateName'] ?? '',
      status: json['status'] ?? false,
    );
  }

  /// Copy helper
  LocalityModel copyWith({
    int? id,
    String? localityName,
    String? cityName,
    String? stateName,
    bool? status,
  }) {
    return LocalityModel(
      id: id ?? this.id,
      localityName: localityName ?? this.localityName,
      cityName: cityName ?? this.cityName,
      stateName: stateName ?? this.stateName,
      status: status ?? this.status,
    );
  }
}