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
  final String customerName;
  final String customerMobile;

  final String vendorName;
  final String vendorMobile;

  final String vendorNumber;

  final String createdAt;
  final String address;
  final String paymentMethod;
  final double latitude;
  final double longitude;
  final String source;

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
    required this.customerName,
    required this.customerMobile,

    required this.vendorNumber,

    required this.createdAt,
    required this.address,
    required this.paymentMethod,
    required this.latitude,
    required this.longitude,
    required this.source,
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
      customerName: json['customerName']?.toString() ?? '',

      customerMobile: json['customerMobile']?.toString() ?? '',

      createdAt: json['createdAt']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      paymentMethod: json['paymentMethod']?.toString() ?? '',

      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,

      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,

      source: json['source']?.toString() ?? '',
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
      'customerName': customerName,
      'customerMobile': customerMobile,

      'createdAt': createdAt,
      'address': address,
      'paymentMethod': paymentMethod,
      'latitude': latitude,
      'longitude': longitude,
      'source': source,
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
    String? customerName,
    String? customerMobile,
    String? paymentMethod,
    double? latitude,
    double? longitude,
    String? source,
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
      customerName: customerName ?? this.customerName,

      customerMobile: customerMobile ?? this.customerMobile,

      vendorNumber: vendorName ?? this.vendorNumber,

      createdAt: createdAt ?? this.createdAt,
      address: address ?? this.address,
      paymentMethod: paymentMethod ?? this.paymentMethod,

      latitude: latitude ?? this.latitude,

      longitude: longitude ?? this.longitude,

      source: source ?? this.source,
    );
  }
}
