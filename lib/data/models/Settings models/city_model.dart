class CityModel {

  /// unique city id
  final int id;

  /// city name
  final String cityName;

  /// state name
  ///
  /// city kis state ke andar hai
  final String stateName;

  /// active/inactive
  bool status;

  CityModel({

    required this.id,

    required this.cityName,

    required this.stateName,

    required this.status,
  });

  /// =====================================
  /// COPY WITH
  /// =====================================
  ///
  /// update/edit ke kaam aata hai

  CityModel copyWith({

    int? id,

    String? cityName,

    String? stateName,

    bool? status,
  }) {

    return CityModel(

      id: id ?? this.id,

      cityName:
      cityName ?? this.cityName,

      stateName:
      stateName ?? this.stateName,

      status:
      status ?? this.status,
    );
  }
}