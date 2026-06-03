// class OrderModel {
//   /// unique id
//   final int id;
//
//   /// service request number
//   final String serviceRequestNumber;
//
//   /// service title
//   final String serviceName;
//
//   /// service amount
//   final double serviceAmount;
//
//   /// booking slot time
//   final String slotTime;
//
//   /// service date
//   final String serviceDate;
//
//   /// city name
//   final String city;
//
//   /// locality / area
//   final String locality;
//
//   /// order status
//   /// example:
//   /// Pending, Assigned, Completed, Cancelled
//   String status;
//
//   /// current vendor name
//   final String vendorName;
//
//   final String address;
//
//   /// created time
//   final String createdAt;
//
//   OrderModel({
//     required this.id,
//     required this.serviceRequestNumber,
//     required this.serviceName,
//     required this.serviceAmount,
//     required this.slotTime,
//     required this.serviceDate,
//     required this.city,
//     required this.locality,
//     required this.status,
//     required this.vendorName,
//     required this.createdAt, required this.address,
//   });
//
//   /// copyWith
//   /// ek-ek field update karne ke liye
//   OrderModel copyWith({
//     int? id,
//     String? serviceRequestNumber,
//     String? serviceName,
//     double? serviceAmount,
//     String? slotTime,
//     String? serviceDate,
//     String? city,
//     String? locality,
//     String? status,
//     String? vendorName,
//     String? createdAt,
//   }) {
//     return OrderModel(
//       id: id ?? this.id,
//       serviceRequestNumber: serviceRequestNumber ?? this.serviceRequestNumber,
//       serviceName: serviceName ?? this.serviceName,
//       serviceAmount: serviceAmount ?? this.serviceAmount,
//       slotTime: slotTime ?? this.slotTime,
//       serviceDate: serviceDate ?? this.serviceDate,
//       city: city ?? this.city,
//       locality: locality ?? this.locality,
//       status: status ?? this.status,
//       vendorName: vendorName ?? this.vendorName,
//       createdAt: createdAt ?? this.createdAt, address: '',
//     );
//   }
// }