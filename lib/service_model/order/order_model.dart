class OrderModel {
  final int id;
  final String serviceRequestNumber;
  final String serviceName;
  final double serviceAmount;
  final String slotTime;
  final String serviceDate;
  final String city;
  final String locality;
  final String status;

  final String vendorName;
  final String vendorMobile;

  final String vendorNumber;

  final String createdAt;
  final String address;

  const OrderModel({
    required this.id,
    required this.serviceRequestNumber,
    required this.serviceName,
    required this.serviceAmount,
    required this.slotTime,
    required this.serviceDate,
    required this.city,
    required this.locality,
    required this.status,

    required this.vendorName,
    required this.vendorMobile,

    required this.vendorNumber,

    required this.createdAt,
    required this.address,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      serviceRequestNumber: json['serviceRequestNumber']?.toString() ?? '',
      serviceName: json['serviceName']?.toString() ?? '',
      serviceAmount: (json['serviceAmount'] as num?)?.toDouble() ?? 0,
      slotTime: json['slotTime']?.toString() ?? '',
      serviceDate: json['serviceDate']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      locality: json['locality']?.toString() ?? '',
      status: json['status']?.toString() ?? '',

      vendorName: json['vendorName']?.toString() ?? '',
      vendorMobile: json['vendorMobile']?.toString() ?? '',

      vendorNumber: json['vendorMobile']?.toString() ?? '',

      createdAt: json['createdAt']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceRequestNumber': serviceRequestNumber,
      'serviceName': serviceName,
      'serviceAmount': serviceAmount,
      'slotTime': slotTime,
      'serviceDate': serviceDate,
      'city': city,
      'locality': locality,
      'status': status,

      'vendorName': vendorName,

      'vendorMobile': vendorNumber,

      'createdAt': createdAt,
      'address': address,
    };
  }

  OrderModel copyWith({
    int? id,
    String? serviceRequestNumber,
    String? serviceName,
    double? serviceAmount,
    String? slotTime,
    String? serviceDate,
    String? city,
    String? locality,
    String? status,
    String? vendorName,
    String? vendorMobile,
    String? createdAt,
    String? address,
  }) {
    return OrderModel(
      id: id ?? this.id,
      serviceRequestNumber: serviceRequestNumber ?? this.serviceRequestNumber,
      serviceName: serviceName ?? this.serviceName,
      serviceAmount: serviceAmount ?? this.serviceAmount,
      slotTime: slotTime ?? this.slotTime,
      serviceDate: serviceDate ?? this.serviceDate,
      city: city ?? this.city,
      locality: locality ?? this.locality,
      status: status ?? this.status,

      vendorName: vendorName ?? this.vendorName,
      vendorMobile: vendorMobile ?? this.vendorMobile,

      vendorNumber: vendorName ?? this.vendorNumber,

      createdAt: createdAt ?? this.createdAt,
      address: address ?? this.address,
    );
  }
}